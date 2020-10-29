#!/usr/bin/env python


## Adapted from 
## https://github.com/sergiocorreia/panflute/blob/master/examples/panflute/graphviz.py
## 
# 
# Copyright (c) 2016, Sergio Correia
# 
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:
# 
#     * Redistributions of source code must retain the above copyright notice,
#       this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright notice,
#       this list of conditions and the following disclaimer in the documentation
#       and/or other materials provided with the distribution.
#     * Neither the name of Sergio Correia nor the names of its contributors
#       may be used to endorse or promote products derived from this software
#       without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# 
"""
Pandoc filter to process "code" blocks with class 
"info", "warning" etc (as used by jekyll-rtd-theme)
into admonition paragraphs.
"""

import os
import sys
from panflute import toJSONFilter, Str, Para, Image, CodeBlock, Block, Header, Div, SmallCaps, convert_text, LineBlock, LineItem

#LEVELS = set("tip note warning danger".split())

EMOJI = {
    "tip": "✅",
    "info": "🛈",
    "warning": "⚠️",
    "danger": "☠️",
}
LEVELS = set(EMOJI.keys())

def admonition(elem, doc):    
    if type(elem) == CodeBlock and (LEVELS & set(elem.classes)):
        level = LEVELS & set(elem.classes)
        code = elem.text
        levelClass = level.pop()
        levelText = Str(EMOJI[levelClass] + " " + levelClass.capitalize())
        content = convert_text(code) # re-parse as markdown
        header = LineBlock(LineItem(SmallCaps(levelText)))
        return Div(header, Div(*content), classes="admonition %s" % levelClass)

if __name__ == "__main__":
    toJSONFilter(admonition)
