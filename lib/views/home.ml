let homepage request =
  let open Tyxml.Html in
  let open Hx in
  let contents =
    div
      [ h2 [ txt "hello" ]
      ; form
          ~a:[ a_id "input_form" ]
          [ Dream.csrf_tag request |> Unsafe.data
          ; input ~a:[ a_name "text" ] ()
          ; button
              ~a:
                [ post "/clicked"
                ; swap SwapType.BeforeEnd
                ; target (Css "#input_form")
                ]
              [ txt "Submit" ]
          ]
      ]
  in
  contents
;;

let get_form request =
  match%lwt Dream.form request with
  | `Ok form_data -> Lwt.return_ok form_data
  | _ -> Lwt.return_error `Missing_form
;;

let item form_data =
  let open Tyxml.Html in
  match form_data with
  | (_, text) :: _ ->
    div
      ~a:[ a_id "parent" ]
      [ h1 [ txt text ]
      ; button
          ~a:
            [ Hs.hyper
                "on click remove the closest #parent to the parentElement of me"
            ; a_class [ "btn"; "btn-primary" ]
            ]
          [ txt "remove" ]
      ]
  | _ -> div [ h1 [ txt "what?" ] ]
;;

let clicked request =
  let open Tyxml.Html in
  let _ = Dream.log "%s" (Dream.client request) in
  match%lwt get_form request with
  | Ok form_data -> item form_data |> Lwt.return
  | _ -> div [ h1 [ txt "eh?" ] ] |> Lwt.return
;;
