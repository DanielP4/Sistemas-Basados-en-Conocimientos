;; Defnine initial state
(deffacts initial-state
  (location monkey corner)
  (location banana middle)
  (location desk left-wall)
  (location chair right-wall)
  (location vase desk)
  (location books chair)
  (hungry monkey)
  (actions ())
)

;; Define rules
(defrule move-to-desk
  (location monkey ?loc)
  (not (location monkey desk))
  (not (location desk middle))
  =>
  (retract (location monkey ?loc))
  (assert (location monkey desk))
  (modify (actions) (bind ?new-actions (create$ (actions) "Monkey moves to the desk.")))
  (retract (actions))
  (assert (actions ?new-actions))
  (printout t "Monkey moves to the desk." crlf)
)

(defrule push-desk
  (location monkey desk)
  (not (location desk middle))
  =>
  (retract (location monkey desk))
  (retract (location desk left-wall))
  (assert (location monkey middle))
  (assert (location desk middle))
  (modify (actions) (bind ?new-actions (create$ (actions) "Monkey pushes the desk to the middle of the room.")))
  (retract (actions))
  (assert (actions ?new-actions))
  (printout t "Monkey pushes the desk to the middle of the room." crlf)
)

(defrule move-to-chair
  (location monkey ?loc)
  (location desk middle)
  (not (location monkey chair))
  =>
  (retract (location monkey ?loc))
  (assert (location monkey chair))
  (modify (actions) (bind ?new-actions (create$ (actions) "Monkey moves to the chair.")))
  (retract (actions))
  (assert (actions ?new-actions))
  (printout t "Monkey moves to the chair." crlf)
)

(defrule push-chair
  (location monkey chair)
  (location chair ?loc)
  (not (location chair desk))
  =>
  (retract (location chair ?loc))
  (assert (location chair desk))
  (modify (actions) (bind ?new-actions (create$ (actions) "Monkey pushes the chair to the desk.")))
  (retract (actions))
  (assert (actions ?new-actions))
  (printout t "Monkey pushes the chair to the desk." crlf)
)

(defrule clear-chair
  (location monkey chair)
  (location books chair)
  (location chair desk)
  =>
  (retract (location books chair))
  (assert (location books floor))
  (modify (actions) (bind ?new-actions (create$ (actions) "Monkey moves the books from the chair to the floor.")))
  (retract (actions))
  (assert (actions ?new-actions))
  (printout t "Monkey moves the books from the chair to the floor." crlf)
)

(defrule climb-onto-chair
  (location monkey chair)
  (not (location books chair))
  (not (location monkey on-chair))
  =>
  (assert (location monkey on-chair))
  (modify (actions) (bind ?new-actions (create$ (actions) "Monkey climbs onto the chair.")))
  (retract (actions))
  (assert (actions ?new-actions))
  (printout t "Monkey climbs onto the chair." crlf)
)

(defrule climb-onto-desk
  (location monkey on-chair)
  (not (location monkey on-desk))
  =>
  (assert (location monkey on-desk))
  (modify (actions) (bind ?new-actions (create$ (actions) "Monkey climbs onto the desk.")))
  (retract (actions))
  (assert (actions ?new-actions))
  (printout t "Monkey climbs onto the desk." crlf)
)

(defrule push-vase
  (location monkey on-desk)
  (location vase desk)
  =>
  (retract (location vase desk))
  (assert (location vase floor))
  (modify (actions) (bind ?new-actions (create$ (actions) "Monkey pushes the vase off the desk.")))
  (retract (actions))
  (assert (actions ?new-actions))
  (printout t "Monkey pushes the vase off the desk." crlf)
)

(defrule move-books
  (location chair desk)
  (location books floor)
  (not (location vase desk))
  =>
  (assert (location books desk))
  (modify (actions) (bind ?new-actions (create$ (actions) "Monkey moves the books onto the desk.")))
  (retract (actions))
  (assert (actions ?new-actions))
  (printout t "Monkey moves the books onto the desk." crlf)
)

(defrule stack-books
  (location monkey on-desk)
  (location books desk)
  =>
  (assert (books-stacked true))
  (modify (actions) (bind ?new-actions (create$ (actions) "Monkey stacks the books on the desk.")))
  (retract (actions))
  (assert (actions ?new-actions))
  (printout t "Monkey stacks the books on the desk." crlf)
)

(defrule climb-stack
  (location monkey on-desk)
  (books-stacked true)
  =>
  (assert (location monkey on-stack))
  (modify (actions) (bind ?new-actions (create$ (actions) "Monkey climbs onto the stack of books.")))
  (retract (actions))
  (assert (actions ?new-actions))
  (printout t "Monkey climbs onto the stack of books." crlf)
)

(defrule unhang-banana
  (location monkey on-stack)
  (location banana middle)
  =>
  (assert (location banana hand))
  (modify (actions) (bind ?new-actions (create$ (actions) "Monkey unhangs the banana.")))
  (retract (actions))
  (assert (actions ?new-actions))
  (printout t "Monkey unhangs the banana." crlf)
)

(defrule eat-banana
  (location banana hand)
  =>
  (assert (hungry monkey false))
  (modify (actions) (bind ?new-actions (create$ (actions) "Monkey eats the banana.")))
  (retract (actions))
  (assert (actions ?new-actions))
  (printout t "Monkey eats the banana." crlf)
)
