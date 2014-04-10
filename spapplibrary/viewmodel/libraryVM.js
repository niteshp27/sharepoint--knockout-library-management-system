var libraryVM = (function (jQ, ko, trace, context, bookListTemplate, userBookListTemplate) {

    var libraryList = function (data) {
        var self = this;
        self.issueBook = function () {
            var currUrl = context.get_url();
            var _cururl = 'https://' + window.location.host + currUrl;
            _cururl += '/Lists/LibraryBookLists/NewForm.aspx?RootFolder=';
            SP.UI.ModalDialog.showModalDialog({ url: _cururl, title: 'Issue Book', allowMaximize: true, showClose: true });
            trace.log("url");
            return false;
        };
        self.bookList = function () {
            self.applyTemplate("#booklist", bookListTemplate, self);
        };
        self.userBookList = function () {
            console.log("displaying user issued books");
            self.applyTemplate("#userbooklist", userBookListTemplate, self);
        };
        self.applyTemplate = function (container, html, viewModel) {
            var listContainer = jQ(container);
            jQ(listContainer).html('');
            jQ(listContainer).append(html);
            ko.cleanNode(listContainer[0]);
            ko.applyBindings(viewModel, listContainer[0]);
            return true;
        };
    };
    return new libraryList();

})(jQ, "../Scripts/knockout-3.1.0.debug.js", logger, appContext, "../templates/bookListTemplate.html", "../templates/userBookListTemplate.html");