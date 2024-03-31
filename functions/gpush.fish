function gpush
    set branch $argv[1] ;
    set commit_message $argv[2..-1] ;

    # Check if branch name is provided
    if test -z "$branch"
        echo "Error: Branch name is required."
        return 1
    end

    # Check if commit message is provided
    if test -z "$commit_message"
        echo "Error: Commit message is required."
        return 1
    end

    # Switch to the specified branch
    git checkout $branch ;

    # Add all changes
    git add . ;

    # Commit changes with the provided message
    git commit -m "$commit_message" ;

    # Push changes to the remote repository
    git push -u origin $branch ;
end
