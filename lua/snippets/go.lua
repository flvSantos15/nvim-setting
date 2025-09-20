-- Verificar se LuaSnip está disponível
local ls_status_ok, ls = pcall(require, "luasnip")
if not ls_status_ok then
  return {}
end

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node

-- Verificar se fmt está disponível
local fmt_status_ok, fmt_lib = pcall(require, "luasnip.extras.fmt")
if not fmt_status_ok then
  return {}
end
local fmt = fmt_lib.fmt

local rep_status_ok, rep_lib = pcall(require, "luasnip.extras")
if not rep_status_ok then
  return {}
end
local rep = rep_lib.rep

return {
  -- Go Main Function
  s("main", fmt([[
package main

import (
  "fmt"
)

func main() {{
  {}
}}
  ]], {
    i(1, 'fmt.Println("Hello, World!")'),
  })),

  -- HTTP Handler
  s("handler", fmt([[
func {}(w http.ResponseWriter, r *http.Request) {{
  {}
  
  w.Header().Set("Content-Type", "application/json")
  w.WriteHeader(http.Status{})
  {}
}}
  ]], {
    i(1, "handlerName"),
    i(2, "// handler logic"),
    c(3, {
      t("OK"),
      t("Created"),
      t("BadRequest"),
      t("InternalServerError"),
    }),
    i(4, "json.NewEncoder(w).Encode(response)"),
  })),

  -- Go Struct
  s("struct", fmt([[
type {} struct {{
  {} {} `json:"{}"`
  {}
}}
  ]], {
    i(1, "StructName"),
    i(2, "Field"),
    i(3, "string"),
    i(4, "field"),
    i(5, "// more fields"),
  })),

  -- Method
  s("method", fmt([[
func ({} *{}) {}({}) {} {{
  {}
}}
  ]], {
    i(1, "receiver"),
    i(2, "ReceiverType"),
    i(3, "MethodName"),
    i(4, "params"),
    i(5, "returnType"),
    i(6, "// method body"),
  })),

  -- Error Handling
  s("err", fmt([[
if err != nil {{
  {}
}}
  ]], {
    c(1, {
      t("return err"),
      t("log.Fatal(err)"),
      t("return nil, err"),
    }),
  })),

  -- Interface
  s("interface", fmt([[
type {} interface {{
  {}({}) {}
}}
  ]], {
    i(1, "InterfaceName"),
    i(2, "MethodName"),
    i(3, "params"),
    i(4, "returnType"),
  })),

  -- Goroutine
  s("go", fmt([[
go func() {{
  {}
}}()
  ]], {
    i(1, "// goroutine code"),
  })),

  -- Channel
  s("chan", fmt([[
{} := make(chan {})
  ]], {
    i(1, "ch"),
    i(2, "string"),
  })),

  -- For range
  s("forr", fmt([[
for {}, {} := range {} {{
  {}
}}
  ]], {
    i(1, "i"),
    i(2, "v"),
    i(3, "slice"),
    i(4, "// code"),
  })),

  -- Context with timeout
  s("ctx", fmt([[
ctx, cancel := context.WithTimeout(context.Background(), {}*time.Second)
defer cancel()
  ]], {
    i(1, "30"),
  })),
}
