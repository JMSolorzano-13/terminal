function ginit
    set branch $argv[1] ;
    set commit_message $argv[2] ;
    set remote_url $argv[3] ;

    # Check if all required parameters are provided
    if test -z "$branch" -o -z "$commit_message" -o -z "$remote_url"
        echo "Error: All parameters are required: branch, commit message, and remote URL."
        return 1
    end

    # Initialize a new Git repository
    git init ;

    # Configure user email and name
    git config user.email "juan.solorzano@globalsitek.com" ;
    git config user.name "JMSolorzano-13" ;

    # Create a new branch and switch to it
    git checkout -b $branch ;

    # Add all changes
    git add . ;

    # Commit changes with the provided message
    git commit -m "$commit_message" ;

    # Add the remote repository
    git remote add origin $remote_url ;

    # Push changes to the remote repository
    git push -u origin $branch ;
end
