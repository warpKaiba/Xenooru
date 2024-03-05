{include file="part.menu.tpl"}

<div class="mx-4 mt-2 animate__animated animate__fadeIn">
    {if $tab == "home"}
        <h1 class="text-xl font-bold mt-1">
            <a href="?tab=aqueue" class="text-red-500 hover:text-red-300">
                » {$lang.approval_queue}
            </a>
        </h1>
        <h1 class="text-xl font-bold mt-1">
            <a href="?tab=creports" class="text-red-500 hover:text-red-300">
                » {$lang.comment_reports}
            </a>
        </h1>
        <h1 class="text-xl font-bold mt-1">
            <a href="?tab=preports" class="text-red-500 hover:text-red-300">
                » {$lang.post_reports}
            </a>
        </h1>
        <h1 class="text-xl font-bold mt-1">
            <a href="?tab=logs" class="text-red-500 hover:text-red-300">
                » {$lang.log_files}
            </a>
        </h1>
    {elseif $tab == "creports"}
        <h1 class="text-2xl font-bold">
                {$lang.comment_reports}
        </h1>

        <div class="mt-2 relative overflow-x-auto">
            <table class="w-full text-sm text-left border border-black">
                <thead class="text-xs uppercase bg-red-500 text-white border border-black text-center">
                    <tr>
                        <th scope="col" class="px-2 py-1 border border-black">
                            {$lang.report} {$lang.by}
                        </th>
                        <th scope="col" class="px-2 py-1 border border-black">
                            {$lang.reason}
                        </th>
                        <th scope="col" class="px-2 py-1 border border-black">
                            {$lang.comment} {$lang.by}
                        </th>
                        <th scope="col" class="px-2 py-1 border border-black">
                            {$lang.comment}
                        </th>
                        <th scope="col" class="px-2 py-1 border border-black">
                            {$lang.date}
                        </th>
                        <th scope="col" class="px-2 py-1 border border-black">
                            ----
                        </th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$creports item=item key=key name=name}
                        <tr class="bg-white hover:bg-gray-50 border border-black">
                            <td class="px-2 py-1 text-right">
                                <a href="/profile.php?id={$item.user}">{$item.username}</a>
                            </td>
                            <th class="px-2 py-1">
                                <p>{$item.reason}</p>
                            </th>
                            <td class="px-2 py-1">
                                <a href="/profile.php?id={$item.reporteduser}">{$item.reportedusername}</a>
                            </td>
                            <td class="px-2 py-1">
                                <a href="/browse.php?page=post&id={$item.reportedcomment.post_id}#comment{$item.comment}">{$item.reportedcomment.comment}</a>
                            </td>
                            <td class="px-2 py-1 text-right">
                                <p>{$item.timestamp}</p>
                            </td>
                            <td class="px-2 py-1 text-right">
                                <p>----</p>
                            </td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    {elseif $tab == "preports"}
        <h1 class="text-2xl font-bold">
                {$lang.post_reports}
        </h1>
    {elseif $tab == "aqueue"}
        <h1 class="text-2xl font-bold">
                {$lang.approval_queue}
        </h1>
    {elseif $tab == "logs"}
        <h1 class="text-2xl font-bold">
                {$lang.log_files}
        </h1>

        <div class="mt-2 relative overflow-x-auto">
            <table class="w-full text-sm text-left border border-black">
                <thead class="text-xs uppercase bg-red-500 text-white border border-black text-center">
                    <tr>
                        <th scope="col" class="px-2 py-1 border border-black">
                            {$lang.username}
                        </th>
                        <th scope="col" class="px-2 py-1 border border-black">
                            {$lang.actions}
                        </th>
                        <th scope="col" class="px-2 py-1 border border-black">
                            {$lang.record}
                        </th>
                        <th scope="col" class="px-2 py-1 border border-black">
                            IP
                        </th>
                        <th scope="col" class="px-2 py-1 border border-black">
                            Success
                        </th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$logs item=item key=key name=name}
                        <tr class="bg-white hover:bg-gray-50 border border-black">
                            <td class="px-2 py-1 text-right">
                                <a href="/profile.php?id={$item.user}">{$item.user}</a>
                            </td>
                            <th class="px-2 py-1">
                                <p>{$item.action}</p>
                            </th>
                            <td class="px-2 py-1">
                                <p>{$item.value}</p>
                            </td>
                            <td class="px-2 py-1">
                                <p>{$item.ip}</p>
                            </td>
                            <td class="px-2 py-1 text-right">
                                <p>{$item.success}</p>
                            </td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>

    {/if}
</div>

{include file="part.footer.tpl"}
