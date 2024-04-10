function ginit
    set branch $argv[1]
    set remote_url $argv[2]

    # Check if all required parameters are provided
    if test -z "$branch" -o -z "$remote_url"
        echo "Error: All parameters are required: branch and remote URL."
        return 1
    end

    # Check if current directory is already part of a git repository
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1
        echo "Error: Current directory is already inside a git repository."
        return 1
    end

    # Initialize a new Git repository
    git init
    echo "Initialize git folder."

    # Create a new branch and switch to it
    git checkout -b $branch
    echo "Create and checkout branch $branch."

    # Add all changes
    git add .
    echo "Add all changes to commit."

    # Commit changes with a default message
    git commit -m "[INIT]"
    echo "Add message to commit."

    # Add the remote repository
    git remote add origin $remote_url
    echo "Add remote repository."

    # Push changes to the remote repository
    git push -u origin $branch
    echo "Push to new repository, new branch."
end
