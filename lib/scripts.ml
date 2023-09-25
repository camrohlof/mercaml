let htmx_script =
  let open Tyxml.Html in
  script ~a:[ a_src "https://unpkg.com/htmx.org@1.9.5" ] (txt "")
;;

let hyperscript_script =
  let open Tyxml.Html in
  script ~a:[ a_src "https://unpkg.com/hyperscript.org@0.9.11" ] (txt "")
;;

let tailwind_script =
  let open Tyxml.Html in
  script ~a:[ a_src "https://cdn.tailwindcss.com" ] (txt "")
;;

let daisy_script =
  let open Tyxml.Html in
  link
    ~rel:[ `Stylesheet ]
    ~href:"https://cdn.jsdelivr.net/npm/daisyui@3.7.7/dist/full.css"
    ()
;;
