# Write.as Export

## Goal

Query the Write.as API and save all blog posts(collections) locally as
Markdown Files.

[Write.as API Docs](https://writeas.github.io/docs/#create-a-collection)


**TODO:**

  - Extract title & data (DONE)
  - Save to Markdown file with the title as the name.(DONE)
  - Save style-sheet. (FROM COLLECTION STRUCT???)


## Installation

  - mix deps.get
  - mix escript.build
  - ./write_export beardyjay


## Example write.as data structure

```
%{"code" => 200,
  "data" => %{
    "alias" => "beardyjay",
    "description" => "Random Rants...",
    "format" => "notebook",
    "posts" => [],
    "public" => false,
    "style_sheet" => "",
    "title" => "",
    "total_posts" => "",
    "views" => 113
   }
}
```

## Fix for ssl error

Main notes on HTTPoison

## Parsing JSON using Poison

https://github.com/devinus/poison


http://stackoverflow.com/questions/30855638/elixir-nested-json-parsing-to-structs


