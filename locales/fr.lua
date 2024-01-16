local Translations = {

    sucess = {
        buy = "Tu as acheté un journal pour ",
        storyupdated = "L'article a été mise à jour !",
        storypublished = "L'article a été publié !",
        storydeleted = "L'article a été supprimé !",
    },
    error = {
        money = " requis pour acheter un journal",
        notjobtoupdate = "Tu ne possède pas le job requis pour mettre a jour l'article",
        notjobtopublish = "Tu ne possède pas le job requis pour publier un article",
        errordelete = "Impossible de supprimer l'article désolé",
    },

}
Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})