local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
  -- Next.js Page Component
  s("page", fmt([[
import {{ NextPage }} from 'next';

interface I{}Props {{
  {}
}}

export function {}({}: I{}Props) {{
  return (
    <div>
      <h1>{}</h1>
      {}
    </div>
  );
}};

{}
  ]], {
    i(1, "PageName"),
    i(2, "// props"),
    rep(1),
    rep(1),
    i(3, "props"),
    i(4, "Page Title"),
    i(5, "// content"),
    rep(1),
    c(6, {
      t(""),
      fmt([[
export async function getStaticProps() {{
  return {{
    props: {{}},
  }};
}}]], {}),
      fmt([[
export async function getServerSideProps() {{
  return {{
    props: {{}},
  }};
}}]], {}),
    }),
  })),

  -- Next.js API Route
  s("api-route", fmt([[
import {{ NextApiRequest, NextApiResponse }} from 'next';

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {{
  if (req.method === '{}') {{
    try {{
      {}
      res.status(200).json({{ {} }});
    }} catch (error) {{
      console.error('API Error:', error);
      res.status(500).json({{ error: 'Internal Server Error' }});
    }}
  }} else {{
    res.setHeader('Allow', ['{}']);
    res.status(405).end(`Method ${{req.method}} Not Allowed`);
  }}
}}
  ]], {
    c(1, {
      t("GET"),
      t("POST"),
      t("PUT"),
      t("DELETE"),
    }),
    i(2, "// logic"),
    i(3, "data"),
    rep(1),
  })),

  -- NestJS Controller
  s("controller", fmt([[
import {{ Controller, Get, Post, Put, Delete, Body, Param, Query }} from '@nestjs/common';
import {{ {}Service }} from './{}.service';
import {{ {} }} from './dto/{}.dto';

@Controller('{}')
export class {}Controller {{
  constructor(private readonly {}Service: {}Service) {{}}

  @Get()
  findAll(@Query() query: any) {{
    return this.{}Service.findAll(query);
  }}

  @Get(':id')
  findOne(@Param('id') id: string) {{
    return this.{}Service.findOne(id);
  }}

  @Post()
  create(@Body() {}: {}) {{
    return this.{}Service.create({});
  }}

  @Put(':id')
  update(@Param('id') id: string, @Body() {}: {}) {{
    return this.{}Service.update(id, {});
  }}

  @Delete(':id')
  remove(@Param('id') id: string) {{
    return this.{}Service.remove(id);
  }}
}}
  ]], {
    i(1, "Service"),
    i(2, "service"),
    i(3, "CreateDto"),
    i(4, "create-dto"),
    i(5, "endpoint"),
    rep(1),
    rep(2),
    rep(1),
    rep(2),
    rep(2),
    i(6, "createDto"),
    rep(3),
    rep(2),
    rep(6),
    i(7, "updateDto"),
    i(8, "UpdateDto"),
    rep(2),
    rep(7),
    rep(2),
  })),

  -- NestJS Service
  s("service", fmt([[
import {{ Injectable }} from '@nestjs/common';
import {{ {} }} from './dto/{}.dto';

@Injectable()
export class {}Service {{
  
  async findAll(query?: any) {{
    {}
  }}

  async findOne(id: string) {{
    {}
  }}

  async create({}: {}) {{
    {}
  }}

  async update(id: string, {}: {}) {{
    {}
  }}

  async remove(id: string) {{
    {}
  }}
}}
  ]], {
    i(1, "CreateDto"),
    i(2, "create-dto"),
    i(3, "ServiceName"),
    i(4, "// implementation"),
    i(5, "// implementation"),
    i(6, "createDto"),
    rep(1),
    i(7, "// implementation"),
    i(8, "updateDto"),
    i(9, "UpdateDto"),
    i(10, "// implementation"),
    i(11, "// implementation"),
  })),

  -- NestJS DTO
  s("dto", fmt([[
import {{ IsString, IsNotEmpty, IsOptional, IsEmail, IsNumber }} from 'class-validator';

export class {} {{
  @IsString()
  @IsNotEmpty()
  {}: string;

  {}
}}
  ]], {
    i(1, "CreateDto"),
    i(2, "name"),
    i(3, "// more properties"),
  })),

  -- React Hook personalizado
  s("hook", fmt([[
import {{ useState, useEffect }} from 'react';

interface IUse{}Options {{
  {}
}}

export const use{} = (options?: IUse{}Options) => {{
  const [data, setData] = useState<{}>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {{
    {}
  }}, []);

  return {{
    data,
    loading,
    error,
    {}
  }};
}};
  ]], {
    i(1, "CustomHook"),
    i(2, "// options"),
    rep(1),
    rep(1),
    i(3, "any"),
    i(4, "// hook logic"),
    i(5, "// return methods"),
  })),

  -- Context Provider
  s("context", fmt([[
import React, {{ createContext, useContext, ReactNode, useState }} from 'react';

interface I{}ContextType {{
  {}
}}

const {}Context = createContext<I{}ContextType | undefined>(undefined);

export const use{} = () => {{
  const context = useContext({}Context);
  if (context === undefined) {{
    throw new Error('use{} must be used within a {}Provider');
  }}
  return context;
}};

interface I{}ProviderProps {{
  children: ReactNode;
}}

export const {}Provider: React.FC<I{}ProviderProps> = ({{ children }}) => {{
  {}

  const value: {}ContextType = {{
    {}
  }};

  return (
    <{}Context.Provider value={{value}}>
      {{children}}
    </{}Context.Provider>
  );
}};
  ]], {
    i(1, "MyContext"),
    i(2, "// context type"),
    rep(1),
    rep(1),
    rep(1),
    rep(1),
    rep(1),
    rep(1),
    rep(1),
    rep(1),
    i(3, "// state"),
    rep(1),
    i(4, "// value object"),
    rep(1),
    rep(1),
  })),

  -- TypeScript Interface
  s("interface", fmt([[
interface I{} {{
  {}: {};
  {}
}}
  ]], {
    i(1, "InterfaceName"),
    i(2, "property"),
    i(3, "string"),
    i(4, "// more properties"),
  })),

  -- TypeScript Type
  s("type", fmt([[
type T{} = {{
  {}: {};
  {}
}};
  ]], {
    i(1, "TypeName"),
    i(2, "property"),
    i(3, "string"),
    i(4, "// more properties"),
  })),

  -- React Component básico
  s("component", fmt([[
import React from 'react';

interface I{}Props {{
  {}
}}

export function {} ({{ {} }}: I{}Props) {{
  return (
    <div className="{}">
      {}
    </div>
  );
}};
  ]], {
    i(1, "ComponentName"),
    i(2, "// props"),
    rep(1),
    i(3, "props"),
    rep(1),
    i(4, "component-name"),
    i(5, "// content"),
  })),

  -- Styled Component (se usar styled-components)
  s("styled", fmt([[
import styled from 'styled-components';

const {} = styled.{}`
  {}
`;
  ]], {
    i(1, "StyledComponent"),
    c(2, {
      t("div"),
      t("span"),
      t("button"),
      t("input"),
      i(1, "element"),
    }),
    i(3, "/* styles */"),
  })),

  -- Custom Hook com TypeScript
  s("customhook", fmt([[
import {{ useState, useEffect }} from 'react';

interface IUse{}Return {{
  {}
}}

export const use{} = (): IUse{}Return => {{
  {}

  return {{
    {}
  }};
}};
  ]], {
    i(1, "CustomHook"),
    i(2, "// return type properties"),
    rep(1),
    rep(1),
    i(3, "// hook implementation"),
    i(4, "// return object"),
  })),

  -- Form Handler
  s("form", fmt([[
import React, {{ useState, FormEvent }} from 'react';

interface I{}FormData {{
  {}
}}

export const {} = () => {{
  const [formData, setFormData] = useState<I{}FormData>({{
    {}
  }});

  const handleSubmit = (e: FormEvent<HTMLFormElement>) => {{
    e.preventDefault();
    {}
  }};

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {{
    setFormData({{
      ...formData,
      [e.target.name]: e.target.value,
    }});
  }};

  return (
    <form onSubmit={{handleSubmit}}>
      {}
      <button type="submit">Submit</button>
    </form>
  );
}};
  ]], {
    i(1, "MyForm"),
    i(2, "name: string;"),
    rep(1),
    rep(1),
    i(3, "name: '',"),
    i(4, "// handle submit"),
    i(5, "// form inputs"),
  })),

  -- Error Boundary
  s("errorboundary", fmt([[
import React, {{ Component, ErrorInfo, ReactNode }} from 'react';

interface IProps {{
  children: ReactNode;
}}

interface IState {{
  hasError: boolean;
  error?: Error;
}}

export class {} extends Component<IProps, IState> {{
  constructor(props: IProps) {{
    super(props);
    this.state = {{ hasError: false }};
  }}

  static getDerivedStateFromError(error: Error): IState {{
    return {{ hasError: true, error }};
  }}

  componentDidCatch(error: Error, errorInfo: ErrorInfo) {{
    console.error('Error caught by boundary:', error, errorInfo);
  }}

  render() {{
    if (this.state.hasError) {{
      return (
        <div className="error-boundary">
          <h2>Something went wrong.</h2>
          <details>
            {{this.state.error?.message}}
          </details>
        </div>
      );
    }}

    return this.props.children;
  }}
}}
  ]], {
    i(1, "ErrorBoundary"),
  })),

  -- Lazy Loading Component
  s("lazy", fmt([[
import React, {{ lazy, Suspense }} from 'react';

const {} = lazy(() => import('./{}'));

export const {}WithSuspense = () => (
  <Suspense fallback={{<div>Loading...</div>}}>
    <{} />
  </Suspense>
);
  ]], {
    i(1, "LazyComponent"),
    rep(1),
    rep(1),
    rep(1),
  })),

  -- Redux Slice (RTK)
  s("slice", fmt([[
import {{ createSlice, PayloadAction }} from '@reduxjs/toolkit';

interface I{}State {{
  {}
}}

const initialState: I{}State = {{
  {}
}};

const {}Slice = createSlice({{
  name: '{}',
  initialState,
  reducers: {{
    set{}: (state, action: PayloadAction<{}>) => {{
      {}
    }},
  }},
}});

export const {{ set{} }} = {}Slice.actions;
export default {}Slice.reducer;
  ]], {
    i(1, "feature"),
    i(2, "// state properties"),
    rep(1),
    i(3, "// initial state"),
    rep(1),
    i(4, "featureName"),
    i(5, "Property"),
    i(6, "PropertyType"),
    i(7, "// reducer logic"),
    rep(5),
    rep(1),
    rep(1),
  })),
}
