#!/usr/bin/env php
<?php
/**
 * Home Environment Setup < setup.php >
 * Sets up CLI user environment and installs various configuration files and apps
 *
 * @author Roy Laurie <roy.laurie@roylaurie.com> RAL
 */

function notice($message)
{
    echo '[' . date('Y-m-d h:m:s') . '] ' . $message . "\n";
    return;
}

function main()
{
    $homePath = $_SERVER['HOME'];
    $user = $_SERVER['USER'];
    $repositoryPath = "{$homePath}/project/rlaurie/home";
    $currentPath = __DIR__;

    if (!is_dir("{$homePath}/bin")) {
        mkdir("{$homePath}/bin", 0755, true);
    }
    if (!is_dir("{$homePath}/tmp")) {
        mkdir("{$homePath}/tmp", 0755, true);
    }
    if (!is_dir("{$homePath}/.old")) {
        mkdir("{$homePath}/.old", 0755, true);
    }
    if (!is_dir("{$homePath}/project/{$user}")) {
        mkdir("{$homePath}/project/{$user}", 0755, true);
    }
    if (!is_dir("{$homePath}/project/rlaurie/home")) {
        mkdir("{$homePath}/project/rlaurie/home", 0755, true);
    }

    // install repository
    if ($currentPath != $repositoryPath) {
        exec("rsync -az {$currentPath}/ {$homePath}/project/rlaurie/home");
    }

    // symlink vimrc
    if (file_exists("{$homePath}/.vimrc") || is_link("{$homePath}/.vimrc")) {
        rename("{$homePath}/.vimrc",  "{$homePath}/.old/.vimrc");
    }

    symlink("{$repositoryPath}/.vimrc", "{$homePath}/.vimrc");

    notice('Finished setup of home environment.');

    return;
}

main();
