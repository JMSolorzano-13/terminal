function ginit
    set branch $argv[1] ;
    set remote_url $argv[3] ;

    # Check if all required parameters are provided
    if test -z "$branch" -o -z "$commit_message" -o -z "$remote_url"
        echo "Error: All parameters are required: branch, commit message, and remote URL."
        return 1
    end

    # Initialize a new Git repository
    git init ;
    echo "Initialize git folder."

    # Create a new branch and switch to it
    git checkout -b $branch ;
    echo "Create and checkuot branch $branch."

    # Add all changes
    git add . ;
    echo "Add all changes to commit."

    # Commit changes with the provided message
    git commit -m "[INIT]" ;
    echo "Add message to commit."

    # Add the remote repository
    git remote add origin $remote_url ;
    echo "Add remote repository."

    # Push changes to the remote repository
    git push -u origin $branch ;
    echo "Push to new repository, new branch."
end
