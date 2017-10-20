---
title: "{{ replace .TranslationBaseName "-" " " | replaceRE "^\\d{4} \\d{2} \\d{2} " "" | title }}"
date: {{ .Date }}
draft: true
authors: ["Rebecca C. Nelson"]
tags: []
categories: ["news"]
---
