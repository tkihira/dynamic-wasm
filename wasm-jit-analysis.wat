;; this is for analysis the actual wasm format
;; this file will show 'Hello, World!' if you read from `wasm-simple.js`

(module
    (import "js" "output" (func $output (param i32)))
    (import "js" "memory" (memory $mem 1))

    (func $compute
        (local $pc i32 (; program counter ;))
        (local $pointer i32 (; pointer ;))

        i32.const 30000
        local.set $pointer 

        (loop $main_loop
            nop
            nop
            nop
            nop

            nop
            nop
            nop
            nop

            nop
            nop
            nop
            nop







                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                (loop $loop0
                    local.get $pointer
                    i32.load
                    i32.eqz
                    (if
                        (then)
                        (else
                nop
                nop
                nop
            
                local.get $pointer
                i32.const 4
                i32.add
                local.set $pointer
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                (loop $loop1
                    local.get $pointer
                    i32.load
                    i32.eqz
                    (if
                        (then)
                        (else
                nop
                nop
                nop
            
                local.get $pointer
                i32.const 4
                i32.add
                local.set $pointer
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer
                i32.const 4
                i32.add
                local.set $pointer
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer
                i32.const 4
                i32.add
                local.set $pointer
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer
                i32.const 4
                i32.add
                local.set $pointer
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer
                i32.const 4
                i32.sub
                local.set $pointer
                nop
                nop
                nop
            
                local.get $pointer
                i32.const 4
                i32.sub
                local.set $pointer
                nop
                nop
                nop
            
                local.get $pointer
                i32.const 4
                i32.sub
                local.set $pointer
                nop
                nop
                nop
            
                local.get $pointer
                i32.const 4
                i32.sub
                local.set $pointer
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.sub

                i32.store
                nop
                nop
                nop
            
                            br $loop1
                        )
                    )
                )
                nop
                nop
                nop
            
                local.get $pointer
                i32.const 4
                i32.add
                local.set $pointer
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer
                i32.const 4
                i32.add
                local.set $pointer
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer
                i32.const 4
                i32.add
                local.set $pointer
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.sub

                i32.store
                nop
                nop
                nop
            
                local.get $pointer
                i32.const 4
                i32.add
                local.set $pointer
                nop
                nop
                nop
            
                local.get $pointer
                i32.const 4
                i32.add
                local.set $pointer
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                (loop $loop1
                    local.get $pointer
                    i32.load
                    i32.eqz
                    (if
                        (then)
                        (else
                nop
                nop
                nop
            
                local.get $pointer
                i32.const 4
                i32.sub
                local.set $pointer
                nop
                nop
                nop
            
                            br $loop1
                        )
                    )
                )
                nop
                nop
                nop
            
                local.get $pointer
                i32.const 4
                i32.sub
                local.set $pointer
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.sub

                i32.store
                nop
                nop
                nop
            
                            br $loop0
                        )
                    )
                )
                nop
                nop
                nop
            
                local.get $pointer
                i32.const 4
                i32.add
                local.set $pointer
                nop
                nop
                nop
            
                local.get $pointer
                i32.const 4
                i32.add
                local.set $pointer
                nop
                nop
                nop
            
                local.get $pointer
                i32.load
                call $output
                nop
                nop
                nop
            
                local.get $pointer
                i32.const 4
                i32.add
                local.set $pointer
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.sub

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.sub

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.sub

                i32.store
                nop
                nop
                nop
            
                local.get $pointer
                i32.load
                call $output
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer
                i32.load
                call $output
                nop
                nop
                nop
            
                local.get $pointer
                i32.load
                call $output
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer
                i32.load
                call $output
                nop
                nop
                nop
            
                local.get $pointer
                i32.const 4
                i32.add
                local.set $pointer
                nop
                nop
                nop
            
                local.get $pointer
                i32.const 4
                i32.add
                local.set $pointer
                nop
                nop
                nop
            
                local.get $pointer
                i32.load
                call $output
                nop
                nop
                nop
            
                local.get $pointer
                i32.const 4
                i32.sub
                local.set $pointer
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.sub

                i32.store
                nop
                nop
                nop
            
                local.get $pointer
                i32.load
                call $output
                nop
                nop
                nop
            
                local.get $pointer
                i32.const 4
                i32.sub
                local.set $pointer
                nop
                nop
                nop
            
                local.get $pointer
                i32.load
                call $output
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer
                i32.load
                call $output
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.sub

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.sub

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.sub

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.sub

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.sub

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.sub

                i32.store
                nop
                nop
                nop
            
                local.get $pointer
                i32.load
                call $output
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.sub

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.sub

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.sub

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.sub

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.sub

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.sub

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.sub

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.sub

                i32.store
                nop
                nop
                nop
            
                local.get $pointer
                i32.load
                call $output
                nop
                nop
                nop
            
                local.get $pointer
                i32.const 4
                i32.add
                local.set $pointer
                nop
                nop
                nop
            
                local.get $pointer
                i32.const 4
                i32.add
                local.set $pointer
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer
                i32.load
                call $output
                nop
                nop
                nop
            
                local.get $pointer
                i32.const 4
                i32.add
                local.set $pointer
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer

                local.get $pointer
                i32.load
                i32.const 1
                i32.add

                i32.store
                nop
                nop
                nop
            
                local.get $pointer
                i32.load
                call $output
                nop
                nop
                nop
            











            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
        )
    )
    (export "compute" (func $compute))
)