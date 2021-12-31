#!/bin/bash

style=https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/2.10.0/github-markdown.min.css
npx md-to-pdf --stylesheet ${style} ./RESUME_ru.MD
npx md-to-pdf --stylesheet ${style} ./RESUME_en.MD

mv *.pdf public
