{include file="part.menu.tpl"}

<div class="mx-4 mt-2">
    {if $tab == "home"}
        <h1 class="text-2xl">{$lang.user_directory} - {$lang.page} {$pagination}</h1>

        <div class="mt-2 relative overflow-x-auto">
            <table class="w-full text-sm text-left border border-black">
                <thead class="text-xs uppercase bg-red-500 text-white border border-black text-center">
                    <tr>
                        <th scope="col" class="px-2 py-1 border border-black">
                            {$lang.actions}
                        </th>
                        <th scope="col" class="px-2 py-1 border border-black">
                            {$lang.username}
                        </th>
                        <th scope="col" class="px-2 py-1 border border-black">
                            {$lang.level}
                        </th>
                        <th scope="col" class="px-2 py-1 border border-black">
                            {$lang.email}
                        </th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$users item=item key=key name=name}
                        <tr class="bg-white hover:bg-gray-50 border border-black">
                            <td class="px-2 py-1 text-right">
                                <a href="profile.php?id={$item._id}" class="text-red-500 hover:text-red-300">{$lang.user}</a>

                                {if $userlevel.perms.can_edit_user}
                                <select oninput="editUser(this.selectedOptions[0]);">
                                    <option value="" selected="" disabled="" hidden="">Change user level</option>
                                    {foreach from=$levels item=level key=key2 name=name2}
                                        {if $userlevel.level >= $level.level}
                                            <option data-level="{$level.level}" data-level-name="{$level.name}" data-user-id="{$item._id}" data-user-name="{$item.username}">
                                                {$level.name}
                                            </option>
                                        {/if}
                                    {/foreach}
                                </select>
                                {/if}
                            </td>
                            <th class="px-2 py-1">
                                <a href="profile.php?id={$item._id}"
                                    class="text-red-500 hover:text-red-300">{$item.username}</a>
                            </th>
                            <td class="px-2 py-1">
                                {$item.level}
                            </td>
                            <td class="px-2 py-1 text-right">
                                {$item.email}
                            </td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    {elseif $tab == "term"}
        <h1 class="text-2xl">{$lang.term}: <a href="browse.php?page=search&query={$smarty.get.term|escape}"
                class="text-red-500 hover:text-red-300">{$smarty.get.term|escape}</a></h1>
        {if $exists}
            <p>
                {bbcodeLink($term.description)}
            </p>
        {else}
            <p>
                {$lang.this_term_has_no_definition_yet}.
            </p>
        {/if}

        <p class="text-sm mt-2">
            <i>
                {if $exists}
                    Created by <a href="profile.php?id={$term.creator}"
                        class="text-red-500 hover:text-red-300">{$term.creator_un}</a> on {$term.timestamp} |
                    Last edited by <a href="profile.php?id={$term.lastedit}"
                        class="text-red-500 hover:text-red-300">{$term.lastedit_un}</a> on {$term.lastedit_ts}
                {else}
                    Never created | Never edited
                {/if}
            </i>
        </p>

        <p>
            {if $userlevel.perms.can_edit_wiki}
                <span class="cursor-pointer text-red-500 hover:text-red-300"
                    onclick="toggleDiv('editDiv');">{$lang.edit_this_term}</span>
            {else}
                {$lang.you_dont_have_permission_to_edit_this_term}.
            {/if}
            |
            {if $exists}
                <a href="logs.php?page=wiki&id={$term._id}" class="text-red-500 hover:text-red-300">{$lang.view_past_edits}</a>
            {else}
                {$lang.there_are_no_past_edits}
            {/if}
        </p>

        {if $userlevel.perms.can_edit_wiki}
            <div id="editDiv" class="hidden">
                <form method="POST" id="editTermForm" name="updateTerm" class="mt-2">
                    <input type="text" name="updateTerm" class="hidden">
                    <label for="description">{$lang.description}</label>
                    <p class="text-sm text-gray-700">{$lang.phrases.this_is_the_description_of_the_term_baka}</p>
                    <textarea name="description" id="description"
                        class="w-full md:w-[400px] min-h-[100px] px-1">{if $exists}{$term.description}{/if}</textarea><br>
                    <input type="number" name="tagId" value="{$tag._id}" class="hidden">
                    {if $exists}
                        <input type="number" name="termId" value="{$term._id}" class="hidden">
                    {/if}
                    <button type="submit" name="updateTerm"
                        class="px-2 mt-1 bg-red-500 text-white hover:bg-red-800">{$lang.save}</button>
                    <button type="button" onclick="toggleDiv('editDiv');"
                        class="px-2 mt-1 border border-red-500 text-red-500 hover:text-white hover:bg-red-300">{$lang.cancel}</button>
                </form>
            </div>
            <p class="mt-2 class" id="editTerm-result"></p>

            <script>
                $("#editTermForm").submit(function(e) {
                    e.preventDefault();
                    $.ajax({
                        type: "POST",
                        url: "ajax.php",
                        data: $(this).serialize(),
                        success: function(data) {
                            if (data == "success") {
                                location.reload();
                            } else {
                                let text = document.getElementById("editTerm-result");
                                text.classList.remove("hidden");
                                text.innerHTML = "<b>Error:</b> " + data;
                                text.classList.add("text-error");
                                text.classList.remove("text-success");
                            }
                        }
                    });
                    return false;
                });
            </script>
        {/if}
    {/if}
</div>

{include file="part.footer.tpl"}
