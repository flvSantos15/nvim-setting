local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
  -- Java Class
  s("class", fmt([[
public class {} {{
  {}
  
  public {}() {{
    {}
  }}
  
  {}
}}
  ]], {
    i(1, "ClassName"),
    i(2, "// fields"),
    rep(1),
    i(3, "// constructor body"),
    i(4, "// methods"),
  })),

  -- Spring Boot Controller
  s("controller", fmt([[
@RestController
@RequestMapping("/{}")
@CrossOrigin(origins = "*")
public class {} {{
  
  @Autowired
  private {} {};
  
  @GetMapping
  public ResponseEntity<List<{}>> getAll() {{
    try {{
      List<{}> {} = {}.findAll();
      return ResponseEntity.ok({});
    }} catch (Exception e) {{
      return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
    }}
  }}
  
  @GetMapping("/{{id}}")
  public ResponseEntity<{}> getById(@PathVariable Long id) {{
    try {{
      Optional<{}> {} = {}.findById(id);
      return {}.map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
    }} catch (Exception e) {{
      return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
    }}
  }}
  
  @PostMapping
  public ResponseEntity<{}> create(@RequestBody {} {}) {{
    try {{
      {} saved = {}.save({});
      return ResponseEntity.status(HttpStatus.CREATED).body(saved);
    }} catch (Exception e) {{
      return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
    }}
  }}
  
  @PutMapping("/{{id}}")
  public ResponseEntity<{}> update(@PathVariable Long id, @RequestBody {} {}) {{
    try {{
      if (!{}.existsById(id)) {{
        return ResponseEntity.notFound().build();
      }}
      {}.setId(id);
      {} updated = {}.save({});
      return ResponseEntity.ok(updated);
    }} catch (Exception e) {{
      return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
    }}
  }}
  
  @DeleteMapping("/{{id}}")
  public ResponseEntity<Void> delete(@PathVariable Long id) {{
    try {{
      if (!{}.existsById(id)) {{
        return ResponseEntity.notFound().build();
      }}
      {}.deleteById(id);
      return ResponseEntity.noContent().build();
    }} catch (Exception e) {{
      return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
    }}
  }}
}}
  ]], {
    i(1, "api/users"),
    i(2, "UserController"),
    i(3, "UserService"),
    i(4, "userService"),
    i(5, "User"),
    rep(5),
    i(6, "users"),
    rep(4),
    rep(6),
    rep(5),
    rep(5),
    i(7, "user"),
    rep(4),
    rep(7),
    rep(5),
    rep(5),
    i(8, "userDto"),
    rep(5),
    rep(4),
    rep(8),
    rep(5),
    rep(5),
    i(9, "updateDto"),
    rep(4),
    rep(9),
    rep(5),
    rep(4),
    rep(9),
    rep(4),
    rep(4),
  })),

  -- Spring Service
  s("service", fmt([[
@Service
@Transactional
public class {} {{
  
  @Autowired
  private {} {};
  
  public List<{}> findAll() {{
    return {}.findAll();
  }}
  
  public Optional<{}> findById(Long id) {{
    return {}.findById(id);
  }}
  
  public {} save({} {}) {{
    return {}.save({});
  }}
  
  public void deleteById(Long id) {{
    {}.deleteById(id);
  }}
  
  public boolean existsById(Long id) {{
    return {}.existsById(id);
  }}
  
  {}
}}
  ]], {
    i(1, "UserService"),
    i(2, "UserRepository"),
    i(3, "userRepository"),
    i(4, "User"),
    rep(3),
    rep(4),
    rep(3),
    rep(4),
    rep(4),
    i(5, "entity"),
    rep(3),
    rep(5),
    rep(3),
    rep(3),
    i(6, "// additional methods"),
  })),

  -- JPA Repository
  s("repository", fmt([[
@Repository
public interface {} extends JpaRepository<{}, {}> {{
  
  List<{}> findBy{}({} {});
  
  Optional<{}> findBy{}({} {});
  
  boolean existsBy{}({} {});
  
  void deleteBy{}({} {});
  
  {}
}}
  ]], {
    i(1, "UserRepository"),
    i(2, "User"),
    i(3, "Long"),
    rep(2),
    i(4, "Name"),
    i(5, "String"),
    i(6, "name"),
    rep(2),
    rep(4),
    rep(5),
    i(7, "field"),
    rep(4),
    rep(5),
    i(8, "param"),
    rep(4),
    rep(5),
    i(9, "value"),
    i(10, "// custom queries with @Query"),
  })),

  -- JPA Entity
  s("entity", fmt([[
@Entity
@Table(name = "{}")
public class {} {{
  
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;
  
  @Column(name = "{}", nullable = false)
  private {} {};
  
  {}
  
  // Constructors
  public {}() {{}}
  
  public {}({} {}) {{
    this.{} = {};
  }}
  
  // Getters and Setters
  public Long getId() {{
    return id;
  }}
  
  public void setId(Long id) {{
    this.id = id;
  }}
  
  public {} get{}() {{
    return {};
  }}
  
  public void set{}({} {}) {{
    this.{} = {};
  }}
  
  {}
}}
  ]], {
    i(1, "users"),
    i(2, "User"),
    i(3, "name"),
    i(4, "String"),
    i(5, "name"),
    i(6, "// additional fields"),
    rep(2),
    rep(2),
    rep(4),
    rep(5),
    rep(5),
    rep(5),
    rep(4),
    f(function(args)
      local field = args[1][1]
      if field and field ~= "" then
        return field:sub(1,1):upper() .. field:sub(2)
      end
      return "Name"
    end, {5}),
    rep(5),
    f(function(args)
      local field = args[1][1]
      if field and field ~= "" then
        return field:sub(1,1):upper() .. field:sub(2)
      end
      return "Name"
    end, {5}),
    rep(4),
    rep(5),
    rep(5),
    rep(5),
    i(7, "// additional getters and setters"),
  })),

  -- DTO Class
  s("dto", fmt([[
public class {} {{
  
  private {} {};
  
  {}
  
  // Constructors
  public {}() {{}}
  
  public {}({} {}) {{
    this.{} = {};
  }}
  
  // Getters and Setters
  public {} get{}() {{
    return {};
  }}
  
  public void set{}({} {}) {{
    this.{} = {};
  }}
  
  {}
}}
  ]], {
    i(1, "UserDto"),
    i(2, "String"),
    i(3, "name"),
    i(4, "// additional fields"),
    rep(1),
    rep(1),
    rep(2),
    rep(3),
    rep(3),
    rep(3),
    rep(2),
    f(function(args)
      local field = args[1][1]
      if field and field ~= "" then
        return field:sub(1,1):upper() .. field:sub(2)
      end
      return "Name"
    end, {3}),
    rep(3),
    f(function(args)
      local field = args[1][1]
      if field and field ~= "" then
        return field:sub(1,1):upper() .. field:sub(2)
      end
      return "Name"
    end, {3}),
    rep(2),
    rep(3),
    rep(3),
    rep(3),
    i(5, "// additional getters and setters"),
  })),

  -- Exception Handler
  s("exception", fmt([[
@ControllerAdvice
public class {} {{
  
  @ExceptionHandler({}.class)
  public ResponseEntity<String> handle{}({} ex) {{
    return ResponseEntity.status(HttpStatus.{}).body(ex.getMessage());
  }}
  
  @ExceptionHandler(Exception.class)
  public ResponseEntity<String> handleGeneral(Exception ex) {{
    return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
        .body("Internal server error: " + ex.getMessage());
  }}
  
  {}
}}
  ]], {
    i(1, "GlobalExceptionHandler"),
    i(2, "ResourceNotFoundException"),
    rep(2),
    rep(2),
    c(3, {
      t("NOT_FOUND"),
      t("BAD_REQUEST"),
      t("UNAUTHORIZED"),
      t("FORBIDDEN"),
    }),
    i(4, "// additional exception handlers"),
  })),

  -- Configuration Class
  s("config", fmt([[
@Configuration
@EnableWebSecurity
public class {} {{
  
  @Bean
  public {} {}() {{
    return new {}();
  }}
  
  {}
}}
  ]], {
    i(1, "SecurityConfig"),
    i(2, "PasswordEncoder"),
    i(3, "passwordEncoder"),
    i(4, "BCryptPasswordEncoder"),
    i(5, "// additional beans"),
  })),

  -- Test Class
  s("test", fmt([[
@SpringBootTest
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
class {} {{
  
  @Autowired
  private {} {};
  
  @Test
  void {}() {{
    // Given
    {}
    
    // When
    {}
    
    // Then
    {}
  }}
  
  {}
}}
  ]], {
    i(1, "UserServiceTest"),
    i(2, "UserService"),
    i(3, "userService"),
    i(4, "shouldReturnUserWhenFound"),
    i(5, "// test data setup"),
    i(6, "// method call"),
    i(7, "// assertions"),
    i(8, "// additional tests"),
  })),

  -- Main method
  s("main", fmt([[
public static void main(String[] args) {{
  {}
}}
  ]], {
    i(1, 'System.out.println("Hello World!");'),
  })),

  -- Try-catch
  s("try", fmt([[
try {{
  {}
}} catch ({} e) {{
  {}
}}
  ]], {
    i(1, "// code that may throw exception"),
    i(2, "Exception"),
    i(3, "e.printStackTrace();"),
  })),

  -- For loop
  s("for", fmt([[
for (int {} = 0; {} < {}; {}++) {{
  {}
}}
  ]], {
    i(1, "i"),
    rep(1),
    i(2, "length"),
    rep(1),
    i(3, "// loop body"),
  })),

  -- Enhanced for loop
  s("fore", fmt([[
for ({} {} : {}) {{
  {}
}}
  ]], {
    i(1, "String"),
    i(2, "item"),
    i(3, "collection"),
    i(4, "// loop body"),
  })),
}
