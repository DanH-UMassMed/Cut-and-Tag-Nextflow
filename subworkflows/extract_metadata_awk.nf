/*
 * Generate table-based metadata from a summary report using AWK 
 */

include { AWK_SCRIPT } from '../modules/linux'
include { AWK }        from '../modules/linux'

workflow EXTRACT_METADATA_AWK {
    take:
    report
    script
    script_mode // bool

    main:
    ch_metadata = Channel.empty()

    // Can run awk in script mode with a file from assets or with a setup of command line args
    if(script_mode) {
        AWK_SCRIPT ( report, script )
        ch_metadata = AWK_SCRIPT.out.file
    }
    else {
        AWK ( report )
        ch_metadata = AWK.out.file
    }

    emit:
    metadata   = ch_metadata // channel: [ val(meta), [ metdatafile ] ]
}