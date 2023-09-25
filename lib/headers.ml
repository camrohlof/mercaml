let navbar elts =
  let open Tyxml.Html in
  nav ~a:[ a_class [ "navbar" ] ] [ ol elts ]
;;

let header body_slot =
  let open Tyxml.Html in
  html
    (head
       (title (txt "Welcome to Merlin"))
       Scripts.
         [ htmx_script; hyperscript_script; tailwind_script; daisy_script ])
    (body [ navbar []; body_slot ])
;;
