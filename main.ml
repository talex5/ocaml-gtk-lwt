(* From http://ocsigen.org/lwt/api/Lwt_glib *)
let () =
  (* Initializes GTK. *)
  ignore (GMain.init ());

  (* Install Lwt<->Glib integration. *)
  Lwt_glib.install ();

  (* Thread which is wakeup when the main window is closed. *)
  let waiter, wakener = Lwt.wait () in

  (* Create a window. *)
  let window = GWindow.window () in

  (* Display something inside the window. *)
  ignore (GMisc.label ~text:"Hello, world!" ~packing:window#add ());

  (* Quit when the window is closed. *)
  ignore (window#connect#destroy (Lwt.wakeup wakener));

  (* Show the window. *)
  window#show ();

  (* Wait for it to be closed. *)
  Lwt_main.run waiter
