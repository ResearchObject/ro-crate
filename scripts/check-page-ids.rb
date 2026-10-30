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

# Check that the domains, tasks, roles and use cases referenced by use case
# pages, related_pages front matter and the related_pages of tools in
# docs/_data/tool_and_resource_list.yml match the page_id of an existing
# page, and that each tool has a unique id. Jekyll silently drops links to
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
# fields of the Elixir Toolkit Theme tool_and_resource_list.yml, plus status, level and subitems
TOOL_KEYS = %w[id name description url status level subitems related_pages
               registry instances instance_of how_to_access].freeze

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

tools_file = File.join(DOCS, "_data", "tool_and_resource_list.yml")
tool_ids = Hash.new(0)
YAML.safe_load(File.read(tools_file, encoding: "UTF-8")).each do |tool|
  where = "#{relative(tools_file)} '#{tool['name']}'"
  tool_ids[tool["id"]] += 1 if tool["id"]
  problems << [relative(tools_file), "#{where}: missing id"] unless tool["id"]
  (tool.keys - TOOL_KEYS).each { |key| problems << [relative(tools_file), "#{where}: unexpected key '#{key}'"] }
  related = tool["related_pages"]
  next if related.nil?
  unless related.is_a?(Array)
    problems << [relative(tools_file), "#{where}: related_pages should be a list, not #{related.inspect}"]
    next
  end
  # tool related_pages mix domains, tasks, roles and use cases
  related.compact.each do |id|
    type = TYPES.find { |t| ids[t].include?(id) }
    if type
      used[type] << id
    else
      problems << [relative(tools_file), "#{where}: unknown related_pages id '#{id}'"]
    end
  end
end
tool_ids.select { |_, count| count > 1 }.each_key do |id|
  problems << [relative(tools_file), "duplicate tool id '#{id}'"]
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
