import nextflow.Nextflow
import java.util.UUID
import java.text.SimpleDateFormat
import java.util.Date

class WorkflowUtils {

    public static void initialize(params, log) {
        // Check input has been provided
        if (!params.sample_sheet) {
            Nextflow.error("Please provide an input samplesheet to the pipeline e.g. '--sample_sheet samplesheet.csv'")
        }
    }

    
    //
    // Get attribute from genome config file e.g. fasta
    //
    public static Object getGenomeAttribute(params, attribute) {
        if (params.genomes && params.genome && params.genomes.containsKey(params.genome)) {
            if (params.genomes[ params.genome ].containsKey(attribute)) {
                return params.genomes[ params.genome ][ attribute ]
            }
        }
        return null
    }

    //
    // Get attribute from genome config file e.g. fasta
    //
    public static String getGenomeAttributeSpikeIn(params, attribute) {
        def val = ''
        if (params.genomes && params.spikein_genome && params.genomes.containsKey(params.spikein_genome)) {
            if (params.genomes[ params.spikein_genome ].containsKey(attribute)) {
                val = params.genomes[ params.spikein_genome ][ attribute ]
            }
        }
        return val
    }
}