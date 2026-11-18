#!/usr/bin/env fish

function help
    echo 'Usage: parseini [FILEPATH] [SECTION] [KEY]

            Options:
            --help|-h  Print help.'
end

function parseini
    argparse -n name 'h/help' -- $argv; or return 0
    if set -q _flag_help
        help
        return 0
    end

    set -l filepath $argv[1]
    set -l section $argv[2]
    set -l key $argv[3]

    while read -l line
        set -a lines $line
    end < $filepath

    set counter 0
    set switch false
    for i in $lines
        if string match -q -- '[*' $i
            set counter (math $counter+1)
        end
        set -a lines$counter $i
    end
    for i in (seq 1 $counter)
        set -l var "lines$i"
        if string match -qi -- "[$section]" $$var
            for a in $$var
                set b (string lower -- $a)
                if string match -qir -- "^$key=*" $b
                    echo $a
                end
            end
        end
    end
end