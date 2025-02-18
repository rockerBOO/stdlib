/// Writes a string to standard output.
///
/// If you want your output to be printed on its own line see `println`.
///
/// ## Example
///
/// ```
/// > io.print("Hi mum")
/// // -> Hi mum
/// Nil
/// ```
///
pub fn print(string: String) -> Nil {
  do_print(string)
}

if erlang {
  external fn do_print(string: String) -> Nil =
    "gleam_stdlib" "print"
}

if javascript {
  external fn do_print(String) -> Nil =
    "../gleam_stdlib.mjs" "print"
}

/// Writes a string to standard output, appending a newline to the end.
///
/// ## Example
///
///    > io.println("Hi mum")
///    // -> Hi mum
///    Nil
///
pub fn println(string: String) -> Nil {
  do_println(string)
}

if erlang {
  external fn do_println(string: String) -> Nil =
    "gleam_stdlib" "println"
}

if javascript {
  external fn do_println(String) -> Nil =
    "../gleam_stdlib.mjs" "log"
}

/// Prints a value to standard output using Erlang syntax.
///
/// The value is returned after being printed so it can be used in pipelines.
///
/// ## Example
///
///    > io.debug("Hi mum")
///    // -> <<"Hi mum">>
///    "Hi mum"
///
///    > io.debug(Ok(1))
///    // -> {ok, 1}
///    Ok(1)
///
///    > import list
///    > [1, 2]
///    > |> list.map(fn(x) { x + 1 })
///    > |> io.debug
///    > |> list.map(fn(x) { x * 2 })
///    // -> [2, 3]
///    [4, 6]
///
pub fn debug(term: anything) -> anything {
  debug_print(term)
  term
}

if erlang {
  fn debug_print(term: anything) -> DoNotLeak {
    erlang_fwrite("~tp\n", [term])
  }
}

if javascript {
  external fn debug_print(anything) -> Nil =
    "../gleam_stdlib.mjs" "debug"
}

if erlang {
  external type DoNotLeak

  external fn erlang_fwrite(String, List(a)) -> DoNotLeak =
    "io" "fwrite"
}
