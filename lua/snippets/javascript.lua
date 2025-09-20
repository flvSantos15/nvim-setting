local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
  -- React Functional Component
  s("rfc", fmt([[
import React from 'react';

interface I{}Props {{
  {}
}}

export function {} ({}: I{}Props) {{
  return (
    <div>
      {}
    </div>
  );
}};

  ]], {
    i(1, "ComponentName"),
    i(2, "// props"),
    rep(1),
    rep(1),
    i(3, "props"),
    i(4, "// content"),
    rep(1),
  })),

  -- useState Hook
  s("useState", fmt([[
const [{}, set{}] = useState{}({});
  ]], {
    i(1, "state"),
    f(function(args)
      local state = args[1][1]
      if state and state ~= "" then
        return state:sub(1,1):upper() .. state:sub(2)
      end
      return "State"
    end, {1}),
    c(2, {
      t(""),
      fmt("<{}>", {i(1, "type")}),
    }),
    i(3, "initialValue"),
  })),

  -- useEffect Hook
  s("useEffect", fmt([[
useEffect(() => {{
  {}
  {}
}}, [{}]);
  ]], {
    i(1, "// effect"),
    c(2, {
      t(""),
      fmt([[
  
  return () => {{
    {}
  }};]], {i(1, "// cleanup")}),
    }),
    i(3, "dependencies"),
  })),

  -- Console.log
  s("cl", fmt("console.log({}{});", {
    c(1, {
      i(1, "value"),
      fmt("'{}'", {i(1, "message")}),
      fmt("'{}', {}", {i(1, "message"), i(2, "value")}),
    }),
    i(2),
  })),

  -- Arrow Function
  s("afn", fmt([[
const {} = ({}) => {{
  {}
}};
  ]], {
    i(1, "functionName"),
    i(2, "params"),
    i(3, "// body"),
  })),

  -- Async Arrow Function
  s("aafn", fmt([[
const {} = async ({}) => {{
  try {{
    {}
  }} catch (error) {{
    console.error('Error in {}:', error);
  }}
}};
  ]], {
    i(1, "functionName"),
    i(2, "params"),
    i(3, "// async code"),
    rep(1),
  })),

  -- API Fetch
  s("api", fmt([[
const {} = async () => {{
  try {{
    const response = await fetch('{}');
    if (!response.ok) {{
      throw new Error(`HTTP error! status: ${{response.status}}`);
    }}
    const data = await response.json();
    {}
  }} catch (error) {{
    console.error('Error fetching data:', error);
    {}
  }}
}};
  ]], {
    i(1, "fetchData"),
    i(2, "url"),
    i(3, "// handle data"),
    i(4, "// handle error"),
  })),

  -- Try Catch
  s("tryc", fmt([[
try {{
  {}
}} catch ({}) {{
  {}
}}
  ]], {
    i(1, "// code"),
    i(2, "error"),
    i(3, "console.error('Error:', error);"),
  })),

  -- Promise
  s("promise", fmt([[
const {} = new Promise((resolve, reject) => {{
  {}
}});
  ]], {
    i(1, "promiseName"),
    i(2, "// promise code"),
  })),

  -- Async/Await
  s("async", fmt([[
async function {}({}) {{
  try {{
    {}
  }} catch (error) {{
    console.error('Error:', error);
    throw error;
  }}
}}
  ]], {
    i(1, "functionName"),
    i(2, "params"),
    i(3, "// async code"),
  })),

  -- For Loop
  s("for", fmt([[
for (let {} = 0; {} < {}; {}++) {{
  {}
}}
  ]], {
    i(1, "i"),
    rep(1),
    i(2, "length"),
    rep(1),
    i(3, "// code"),
  })),

  -- For...of Loop
  s("forof", fmt([[
for (const {} of {}) {{
  {}
}}
  ]], {
    i(1, "item"),
    i(2, "array"),
    i(3, "// code"),
  })),

  -- For...in Loop
  s("forin", fmt([[
for (const {} in {}) {{
  {}
}}
  ]], {
    i(1, "key"),
    i(2, "object"),
    i(3, "// code"),
  })),

  -- Array Methods
  s("map", fmt([[
{}.map(({}) => {{
  {}
}});
  ]], {
    i(1, "array"),
    i(2, "item"),
    i(3, "return item;"),
  })),

  s("filter", fmt([[
{}.filter(({}) => {{
  {}
}});
  ]], {
    i(1, "array"),
    i(2, "item"),
    i(3, "return condition;"),
  })),

  s("reduce", fmt([[
{}.reduce((acc, {}) => {{
  {}
  return acc;
}}, {});
  ]], {
    i(1, "array"),
    i(2, "item"),
    i(3, "// reducer logic"),
    i(4, "initialValue"),
  })),

  -- Object Destructuring
  s("dest", fmt("const {{ {} }} = {};", {
    i(1, "property"),
    i(2, "object"),
  })),

  -- Array Destructuring
  s("desta", fmt("const [{}] = {};", {
    i(1, "item"),
    i(2, "array"),
  })),

  -- Import statements
  s("imp", fmt("import {} from '{}';", {
    i(1, "module"),
    i(2, "path"),
  })),

  s("impd", fmt("import {{ {} }} from '{}';", {
    i(1, "destructured"),
    i(2, "path"),
  })),

  -- Export statements
  s("exp", fmt("export const {} = {};", {
    i(1, "name"),
    i(2, "value"),
  })),

  s("expd", fmt("export default {};", {
    i(1, "value"),
  })),
}
