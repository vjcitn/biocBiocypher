# necessary for python module control
#' python declarations
#' @import basilisk
#' @import reticulate
bsklenv <- basilisk::BasiliskEnvironment(
  envname = "bsklenv",
  pkgname = "biocBiocypher",
  packages = c("python==3.9", "numpy==1.23.1", "pandas==1.4.4"),
  pip = c(
    "biocypher==0.5.11"
    )
  )


#' simple interface to Biocypher
#' @export
loadBiocypher = function() {
  proc <- basilisk::basiliskStart(bsklenv)
  on.exit(basilisk::basiliskStop(proc))
  biocypher_ref = basilisk::basiliskRun(proc, function() {
    reticulate::import("biocypher")
  })
  generator_ref = basilisk::basiliskRun(proc, function() {
    reticulate::py_run_file(system.file("python", "node_generator.py", package="biocBiocypher"))
  })
  ans = list(biocypher_ref = biocypher_ref, generator_ref = generator_ref)
  class(ans) = c("biocypher_refs", "list")
  ans
}

#' printer for refs
#' @param x biocypher_refs instance
#' @param \dots not used
#' @export
print.biocypher_refs = function(x, ...) {
 cat("biocypher_refs produced with basilisk.\n")
 cat(" use $biocypher_ref for modules, $generator_ref for simulator\n")
}


