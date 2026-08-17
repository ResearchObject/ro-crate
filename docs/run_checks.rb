# run custom checks defined in custom_html_tests.rb
require 'html-proofer'

require_relative 'tests/custom_html_tests.rb'

# avoid h1 in Markdown - exclude spec pages which do have these (see README.md)
HTMLProofer.check_directory("_site/", { checks: ["CheckH1NotInMarkdown"], ignore_files: [%r|_site/specification/.*|]}).run
# enforce h1 in front matter
HTMLProofer.check_directory("_site/", { checks: ["CheckH1InIntro"]}).run 
