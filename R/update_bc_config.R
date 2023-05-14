#' modify basic BioCypher configuration to reroute log and output to specified folders
#' @import yaml
#' @param confpath character(1) path to a typical BioCypher configuration which by
#' default would write log and output to current folder
#' @param outputDir character(1) path to output
#' @param logDir character(1) path to logs
#' @param tmpstore path to revised configuration YAML
#' @note Creates logDir
#' @export
update_bc_config = function(confpath, outputDir=tempfile("biocyphOutput"),
    logDir=tempfile("biocyphLogs"), tmpstore=tempfile()) {
 input = yaml::read_yaml(confpath)
 try(dir.create(logDir))
 input$biocypher$log_directory = logDir
 input$biocypher$output_directory = outputDir
 yaml::write_yaml(input, file=tmpstore)
 tmpstore
}
