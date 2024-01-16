local Translations = {

    success = {
        buy = "You buy a newspaper for ",
        storyupdated = "Story has been updated!",
        storypublished = "Story has been published!",
        storydeleted = "Story has been deleted!",
    },
    error = {
        money = " required for buying a newspaper",
        notjobtoupdate = 'You need to be a reporter to update a story',
        notjobtopublish = 'You need to be a reporter to publish a story',
        errordelete = 'Not possible to delete story',
    },

}
Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})