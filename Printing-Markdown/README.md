# Printing Tools
- Files in this directory explain parts of the workflow for Markdown documents to be converted into publishable documents
- This could be used to convert this VIP Linux repository for printing to paper

| **Example usage with `pandoc`** :

```
pandoc Tests.md \
       --output=Tests.html \
       --to=html5
```

- Embed the output in TMPL.html

## References:
- [https://github.com/otsaloma/markdown-css]
- [https://pandoc.org/MANUAL.html#pandocs-markdown]
- [https://github.com/sindresorhus/github-markdown-css]
- [http://manpages.ubuntu.com/manpages/bionic/man1/pandoc.1.html#custom%20styles%20in%20docx%20output]
