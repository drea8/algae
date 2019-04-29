# ALGAE
algebra-geometric automata environment
* 

# Install
requires the YASM assembler to build

# To Do
* (write files) !done
* (read files - x86_64 linux Syscall)

* binary analysis - C gen
* refal - L k f x paper semantics - hand compilation work
* HEXL-MODE on out.buf - for ouput

"dont keep the CPUs hungry"

;; need design up to 4th goal, on 2nd, dynm buf
;; ^cleanup prior
;; check
* summation problem
  add series and display the output in out.buf

* dynamic buffer entry
  1. preallocate free buffers
  2. Repl input number
        -> num of buf blocks to allocate
	-> marks num of buf blocks as allocated
     select buf area pointer to write, of alloc'd num
     write cons data in each cell alloc'd
     read back alloc'd cons data
  3. 
  4.
    interrupt for char input
    num to size of buffer, zero each & print

* symbol store
  def symbol equivalent,
  pointer by name, Actor sys 

* read and parse file char by char
  (SYS READ see "file:///root/algae/doc/assembly_tutorial.pdf")
  data representation

* REFAL/automata/alg-geo representation
  parse graph structure & compiled out
  in files, constantly caching computing


* list x86_64 yasm instructions
* buffer allocation semantics
* formal automata model x86_64 algae
  stack (push/pop) as alt nondet
  recursion, subroutes (pdf.p.71)