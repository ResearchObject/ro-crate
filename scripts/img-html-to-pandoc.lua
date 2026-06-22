-- in our Markdown files we use <img> tags rather than Markdown image syntax
-- Pandoc doesn't parse these as Images, just raw HTML so it doesn't include the images in PDF output
-- this filter finds raw image HTML and converts it to pandoc.Image elements which will appear in the PDF
function RawInline(elem)
    pattern = "<img src=%\"(.*)%\" alt=%\"([^%\"]*)%\""
    src, alt = string.match(elem.text, pattern)
    -- alt is used twice - once as image description and once as alt text attribute
    if src then
        return pandoc.Image(alt, src)
    else
        return elem
    end
end
