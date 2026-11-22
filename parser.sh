#!/usr/bin/env fish

function help
    echo 'Usage: parseini [FILEPATH] [SECTION] [KEY] [REPLACEMENT_KEY](OPTIONAL)

            Options:
            --list_sections List all sections
            --set Replaces the value of the key selected with [REPLACEMENT_KEY]
            --help|-h  Print help.'
end

function parseini
    argparse -n name 'h/help' 'list_sections' 'list_keys' 'set' -- $argv; or return 0
    if set -q _flag_help
        help
        return 0
    end

    set -l filepath $argv[1]
    set -l section $argv[2]
    set -l key $argv[3]
    set -l replace_key $argv[4]
    
    while read -l line
        set -a lines $line
    end < $filepath
    
    set counter 0
    for i in $lines
        if string match -q -- '[*' $i; or string match -q -- '#*' $i
            set counter (math $counter+1)
        end
        set -a lines$counter $i
    end

    
    if set -q _flag_list_sections
        for i in $lines
            if string match -qi -- "[*" $i
                echo $i
            end
        end
        return 0
    end

    set found_key
    set found_section_num
    for i in (seq 1 $counter)
        set -l var "lines$i"
        if string match -qi -- "[$section]" $$var
            set found_section_num $i
            if set -q _flag_list_keys
                string join \n $$var
                return 0
            end
            for a in $$var
                set b (string lower -- $a)
                if string match -qir -- "^\\s*$key\\s*=" $b
                    echo $a
                    set found_key $a
                end
            end
        end  
    end
    set_color brred
    echo "Before: "
    string join \n $lines
    if set -q _flag_set
        set replaced_key (string replace -r '=.*' "= $replace_key" -- $found_key)
        set section lines$found_section_num
        set len (count $$section)
        set key_index
        if set -l key_index (contains -i -- "$found_key" $$section)
            set {$section}[$key_index] "$replaced_key"
        end
        set lines
        for i in (seq 1 $counter)
            set var lines$i
            set -a lines $$var
        end
        set_color brgreen
        echo "After: "
        echo (string join \n $lines | string collect)
        echo (string join \n $lines | string collect) > $filepath
    end
end