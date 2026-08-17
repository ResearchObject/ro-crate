# run custom checks defined in custom_html_checks.rb
# initiate manually from docs/ using `bundle exec ruby tests/test_html_pages.rb`

require 'html-proofer'

require_relative 'custom_html_checks.rb'

# avoid h1 in Markdown - exclude spec pages which do have these (see README.md)
HTMLProofer.check_directory("_site/", { checks: ["CheckH1NotInMarkdown"], ignore_files: [%r|_site/specification/.*|]}).run
# enforce h1 in front matter
HTMLProofer.check_directory("_site/", { checks: ["CheckH1InIntro"]}).run 
