<?php

require "../autoload.php";
if (!$userlevel["perms"]["is_forum_mod"]) header("Location: account.php?tab=login") && die("not a moderator or admin.");

$pages["isAdmin"] = true;
switch ($_GET["tab"] ?? "home") {
    case "creports":
        $tab = "creports";
        $pagination = 1;
        if (isset($_GET["pagination"]) && !empty($_GET["pagination"]) && is_numeric($_GET["pagination"]))
            $pagination = clean($_GET["pagination"]);

        // Pagination
        $pagination = 1;
        $skip = ($pagination - 1) * $config["perpage"]["terms"];

        $creports = $db["commentReports"]->findAll(["_id" => "DESC"], $config["perpage"]["terms"], $skip);
        foreach ($creports as $key => $report) {
            // Get comment data from comments collection
            $xcomment = $db["comments"]->findOneBy(["_id", "==", $report["comment"]]);
            // Add comment data to report
            $creports[$key]["reportedcomment"] = $xcomment;
        }

        $smarty->assign("creports", $creports);
        $smarty->assign("pagination", $pagination);
        break;
    case "preports":
        $tab = "preports";
        break;
    case "aqueue":
        $tab = "aqueue";
        break;
    case "logs":
        $tab = "logs";
        $pagination = 1;
        if (isset($_GET["pagination"]) && !empty($_GET["pagination"]) && is_numeric($_GET["pagination"]))
            $pagination = clean($_GET["pagination"]);

        // Pagination
        $pagination = 1;
        $skip = ($pagination - 1) * $config["perpage"]["terms"];

        $logs = $db["logs"]->findAll(["_id" => "DESC"], $config["perpage"]["terms"], $skip);

        $smarty->assign("logs", $logs);
        $smarty->assign("pagination", $pagination);
        break;
    default:
        $tab = "home";
}
$smarty->assign("tab", $tab);
$smarty->assign("pages", $pages);
$smarty->assign("pagetitle", $lang["admin"]);

require "../endtime.php";

$smarty->display("part.top.tpl");
$smarty->display("page.admin.tpl");
$smarty->display("part.bottom.tpl");
