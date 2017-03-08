# Write.as Export

## Goal

Query the Write.as API and save all blog posts(collections) locally as
Markdown Files.

[Write.as API Docs](https://writeas.github.io/docs/#create-a-collection)

## Installation

  - mix deps.get
  - mix escript.build
  - ./write_export beardyjay
  - ./write_export beardyjay --path <mydirectory>

Posts are saved in the local directory with the name ```posts```.

If a path is specified, it is saved under the ```posts``` directory in the specified path.

## TODO:

* More unit tests


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
