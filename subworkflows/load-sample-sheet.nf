

// This process does Nothing! 
// This enables the workflow to call get_samplesheet_paths 
process SAMPLESHEET_CHECK {
    label 'process_low'

    input:
    path samplesheet

    output:
    path samplesheet 

    script:
    """
    
    """
}

workflow LOAD_SAMPLE_SHEET {
    take:
    samplesheet // file: /path/to/samplesheet.csv

    main:
    SAMPLESHEET_CHECK(samplesheet)

   SAMPLESHEET_CHECK.out 
        .splitCsv ( header:true, sep:"," )
        .map { get_samplesheet_paths(it) }
        .set { reads }
    

    emit:
    reads // channel: [ val(meta), [ reads ] ]
}

// Function to get list of [ meta, [ fastq_1, fastq_2 ] ]
def get_samplesheet_paths(LinkedHashMap row) {
    def meta = [:]
    meta.id            = "${row.group}_${row.replicate}"
    meta.group         = row.group
    meta.replicate     = row.replicate.toInteger()
    meta.single_end    = (row.fastq_2 == "") ? true : false
    meta.is_control    = (row.control == "") ? true : false
    meta.control_group = meta.is_control ? meta.group : row.control

    def array = []
    if (!file(row.fastq_1).exists()) {
        exit 1, "ERROR: Please check input samplesheet -> Read 1 FastQ file does not exist!\n${row.fastq_1}"
    }
    if (meta.single_end) {
        array = [ meta, [ file(row.fastq_1) ] ]
    } else {
        if (!file(row.fastq_2).exists()) {
            exit 1, "ERROR: Please check input samplesheet -> Read 2 FastQ file does not exist!\n${row.fastq_2}"
        }
        array = [ meta, [ file(row.fastq_1), file(row.fastq_2) ] ]
    }
    return array
}