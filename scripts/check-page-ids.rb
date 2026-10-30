#!/usr/bin/env ruby

#   Copyright 2026 RO-Crate contributors <https://github.com/ResearchObject/ro-crate/graphs/contributors>
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

# Check that the domains, tasks, roles and use cases referenced by
# use case pages, docs/_data/tools_list.yml and related_pages front matter
# match the page_id of an existing page. Jekyll silently drops links to
# unknown ids, so a typo hides a use case or tool from a page.
#
# Run as:
#   scripts/check-page-ids.rb [docs]
#
# Exits with status 1 if any reference is unknown.

require "yaml"
require "date"

DOCS = ARGV[0] || File.join(__dir__, "..", "docs")
TYPES = %w[domains tasks roles use_cases].freeze
TAGS = %w[domains tasks roles].freeze
TOOL_KEYS = %w[name description url status level subitems] + TAGS

def front_matter(path)
  match = File.read(path, encoding: "UTF-8").match(/\A---\s*\n(.*?)\n---\s*$/m)
  return {} unless match
  YAML.safe_load(match[1], permitted_classes: [Date, Time]) || {}
end

def relative(path)
  path.delete_prefix(File.join(DOCS, ""))
end

ids = TYPES.to_h do |type|
  pages = Dir.glob(File.join(DOCS, "pages", type, "*.md"))
  [type, pages.filter_map { |page| front_matter(page)["page_id"] }.to_set]
end

problems = []
used = Hash.new { |hash, type| hash[type] = Set.new }

check = lambda do |file, where, type, values|
  return if values.nil?
  unless values.is_a?(Array)
    problems << [file, "#{where}: #{type} should be a list, not #{values.inspect}"]
    return
  end
  values.compact.reject(&:empty?).each do |id|
    used[type] << id
    problems << [file, "#{where}: unknown #{type} id '#{id}'"] unless ids[type].include?(id)
  end
end

Dir.glob(File.join(DOCS, "pages", "use_cases", "*.md")).sort.each do |page|
  meta = front_matter(page)
  TAGS.each { |tag| check.call(relative(page), relative(page), tag, meta[tag]) }
end

tools_file = File.join(DOCS, "_data", "tools_list.yml")
YAML.safe_load(File.read(tools_file, encoding: "UTF-8")).each do |tool|
  where = "#{relative(tools_file)} '#{tool['name']}'"
  TAGS.each { |tag| check.call(relative(tools_file), where, tag, tool[tag]) }
  (tool.keys - TOOL_KEYS).each { |key| problems << [relative(tools_file), "#{where}: unexpected key '#{key}'"] }
end

pages = Dir.glob(File.join(DOCS, "{pages,_blog}", "**", "*.md")).sort
pages.each do |page|
  related = front_matter(page)["related_pages"]
  next unless related.is_a?(Hash)
  where = "#{relative(page)} related_pages"
  related.each do |type, values|
    if TYPES.include?(type)
      check.call(relative(page), where, type, values)
    else
      problems << [relative(page), "#{where}: unknown section '#{type}'"]
    end
  end
end

TAGS.each do |type|
  unused = ids[type].reject { |id| used[type].include?(id) }.sort
  puts "#{type}: #{ids[type].size} pages, never referenced: #{unused.empty? ? '-' : unused.join(', ')}"
end

problems.each do |file, message|
  # GitHub Actions shows these as annotations on the file
  puts ENV["GITHUB_ACTIONS"] ? "::error file=docs/#{file}::#{message}" : message
end
puts problems.empty? ? "All page ids are known." : "#{problems.size} unknown reference(s)."
exit(problems.empty? ? 0 : 1)
