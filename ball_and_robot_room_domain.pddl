(:predicates
    (at-robot ?rob - robot ?rm - room)
    (at-ball ?b - ball ?rm - room)
    (carry ?b - ball ?rob - robot ?grip - gripper)
    (free ?grip - gripper)
)

(:action move
    :parameters (?rob - robot ?rm-from - room ?rm-to - room)
    :precondition(
        and
        (at-robot ?rob ?rm-from)
    )  
    :effect(
        and
        (at-robot ?rob ?rm-to)
        (not (at-robot ?rob ?rm-from))
    )
)

(:action pick
    :parameters (?rob - robot ?b - ball ?grip - gripper ?rm -room)
    :precondition (
        and 
            (at-robot ?rob ?rm) 
            (at-ball ?b ?rm) 
            (free ?grip))
    :effect (and
        (carry ?b ?rob ?grip)
        (not (free ?grip))
        (not (at-ball ?b ?rm))
    )
)

(:action drop
    :parameters (?rob - robot ?b - ball ?grip - gripper ?rm -room)
    :precondition (
        and 
            (at-robot ?rob ?rm) 
            (carry ?b ?rob ?grip))
    :effect (and
        (not (carry ?b ?rob ?grip))
        (free ?grip)
        (at-ball ?b ?rm)
    )
)