require 'html-proofer'

# avoid Markdown h1s
# Markdown content is placed within #content
class CheckH1NotInMarkdown < HTMLProofer::Check
  def run
    @html.css("#content h1").each do |node|
      @heading = create_element(node) 
      return add_failure("Found level 1 heading in Markdown content. Use `title` in front matter instead.", element: @heading)
    end
  end
end

# ensure `title` is set in YAML front matter
class CheckH1InIntro < HTMLProofer::Check
  def run
    # first check that #intro div exists - filters out pages used for redirects
    intro = @html.css('#intro')
    if !blank?(intro)
      # check a title is in the #intro div - this is where ETT puts the `title` from the YAML
      title = @html.css('#intro h1').text
      if blank?(title)
        return add_failure("Page is missing a title - set `title` in YAML front matter")
      end
    end
  end
end
