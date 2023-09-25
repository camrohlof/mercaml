open Base
(* open Lwt_result.Syntax *)

let html_to_string html = Fmt.str "%a" (Tyxml.Html.pp ()) html
let elt_to_string elt = Fmt.str "%a" (Tyxml.Html.pp_elt ()) elt
let add_header html = Mercaml.Headers.header html

let routes =
  [ Dream.get "/" (fun request ->
      Views.Home.homepage request |> add_header |> html_to_string |> Dream.html)
  ; Dream.get "/migration" (fun _ ->
      Views.Migration_profile.index
      |> add_header
      |> html_to_string
      |> Dream.html)
  ; Dream_livereload.route ()
  ; Dream.post "/clicked" (fun contents ->
      let%lwt response = Views.Home.clicked contents in
      response |> elt_to_string |> Dream.html)
  ]
;;

let () =
  Dream.run
  @@ Dream.logger
  @@ Dream.memory_sessions
  @@ Dream_livereload.inject_script ()
  @@ Dream.router routes
;;
