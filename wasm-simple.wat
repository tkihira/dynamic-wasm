(module
    (import "js" "output" (func $output (param i32)))
    (import "js" "memory" (memory $mem 1))

    (func $jump_forward
        (param $pc i32)
        (result i32)
        (local $counter i32)

        (loop $root
            local.get $pc
            i32.load8_u
            i32.const 91 ;; '['
            i32.eq
            (if
                (then
                    local.get $counter
                    i32.const 1
                    i32.add
                    local.set $counter
                )
            )

            local.get $pc
            i32.load8_u
            i32.const 93 ;; ']'
            i32.eq
            (if
                (then
                    local.get $counter
                    i32.const 1
                    i32.sub
                    local.set $counter
                )
            )

            local.get $counter
            i32.const 0
            i32.ne
            (if
                (then
                    local.get $pc
                    i32.const 1
                    i32.add
                    local.set $pc
                    br $root
                )
            )
        )
        
        local.get $pc
    )

    (func $jump_backward
        (param $pc i32)
        (result i32)
        (local $counter i32)

        (loop $root
            local.get $pc
            i32.load8_u
            i32.const 91 ;; '['
            i32.eq
            (if
                (then
                    local.get $counter
                    i32.const 1
                    i32.sub
                    local.set $counter
                )
            )

            local.get $pc
            i32.load8_u
            i32.const 93 ;; ']'
            i32.eq
            (if
                (then
                    local.get $counter
                    i32.const 1
                    i32.add
                    local.set $counter
                )
            )

            local.get $counter
            i32.const 0
            i32.ne
            (if
                (then
                    local.get $pc
                    i32.const 1
                    i32.sub
                    local.set $pc
                    br $root
                )
            )
        )

        local.get $pc
    )



    (func $compute
        (local $pc i32 (; program counter ;))
        (local $pointer i32 (; pointer ;))

        i32.const 30000
        local.set $pointer 

        (loop $main_loop
            local.get $pc
            i32.load8_u
            i32.eqz
            (if
                (then
                    ;; go to the end
                )
                (else

                    local.get $pc
                    i32.load8_u
                    i32.const 62 ;; ">"
                    i32.eq
                    (if
                        (then
                            local.get $pointer
                            i32.const 4
                            i32.add
                            local.set $pointer
                        )
                    )

                    local.get $pc
                    i32.load8_u
                    i32.const 60 ;; "<"
                    i32.eq
                    (if
                        (then
                            local.get $pointer
                            i32.const 4
                            i32.sub
                            local.set $pointer
                        )
                    )

                    local.get $pc
                    i32.load8_u
                    i32.const 43 ;; "+"
                    i32.eq
                    (if
                        (then
                            local.get $pointer

                            local.get $pointer
                            i32.load
                            i32.const 1
                            i32.add

                            i32.store
                        )
                    )

                    local.get $pc
                    i32.load8_u
                    i32.const 45 ;; "-"
                    i32.eq
                    (if
                        (then
                            local.get $pointer

                            local.get $pointer
                            i32.load
                            i32.const 1
                            i32.sub

                            i32.store
                        )
                    )

                    local.get $pc
                    i32.load8_u
                    i32.const 46 ;; "."
                    i32.eq
                    (if
                        (then
                            local.get $pointer
                            i32.load
                            call $output
                        )
                    )

                    local.get $pc
                    i32.load8_u
                    i32.const 91 ;; "["
                    i32.eq
                    (if
                        (then
                            local.get $pointer
                            i32.load
                            i32.eqz
                            (if
                                (then
                                    local.get $pc
                                    call $jump_forward
                                    local.set $pc
                                )
                            )
                        )
                        (else

                            local.get $pc
                            i32.load8_u
                            i32.const 93 ;; "]"
                            i32.eq
                            (if
                                (then
                                    local.get $pointer
                                    i32.load
                                    i32.const 0
                                    i32.ne
                                    (if
                                        (then
                                            local.get $pc
                                            call $jump_backward
                                            local.set $pc
                                        )
                                    )
                                )
                            )

                        )
                    )



                    ;; debug
                    ;;local.get $pc
                    ;;i32.load8_u
                    ;;call $output

                    local.get $pc
                    i32.const 1
                    i32.add
                    local.set $pc

                    br $main_loop
                )
            )
        )
    )
    (export "compute" (func $compute))
)