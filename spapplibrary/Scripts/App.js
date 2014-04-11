/// <reference path="../templates/booklisttemplate.html" />
/// <reference path="../templates/booklisttemplate.html" />
/// <reference path="../templates/booklisttemplate.html" />
/// <reference path="knockout-3.1.0.debug.js" />
//'use strict';

var appContext = SP.ClientContext.get_current();
//var user = appContext.get_web().get_currentUser();
//var currUrl = appContext.get_url();

var jQ = $.noConflict();//,
    //ko= '';







var logger = (function (_window, undefined) {

    function _log(msg) {

        _window.console.log(msg);
    };

    return {
        log: _log
    };

})(window);

var userModule = (function (jQ, trace, context) {


    var userService = function () {

        // This function prepares, loads, and then executes a SharePoint query to get the current users information
        function _printUserName() {

            var user = context.get_web().get_currentUser();

            trace.log("get user");
            context.load(user);
            context.executeQueryAsync(onGetUserNameSuccess, onGetUserNameFail);

            function onGetUserNameSuccess() {
                jQ('#helloBlock').text('Hello ' + user.get_title());
                trace.log("user success");
            };

            // This function is executed if the above call fails
            function onGetUserNameFail(sender, args) {
                trace.log('user Failed to get user name. Error:' + args.get_message());
            };
        };

        return {
            PrintCurrentUser: _printUserName
        };
    };

    return new userService();

})(jQ, logger, appContext);


function issueBook() {
    
    var currUrl = appContext.get_url();
    var _cururl = 'https://' + window.location.host + currUrl;
    _cururl += '/Lists/LibraryBookLists/NewForm.aspx?RootFolder=';
    SP.UI.ModalDialog.showModalDialog({ url: _cururl, title: 'Issue Book', allowMaximize: true, showClose: true });
    logger.log("url");
    return false;
};

//bookissuedto function/model
function booksIssuedToUser(data) {
    var self = this;
    self.Title = ko.observable(data.Title);
    self.IssuedTo = ko.observable(data.IssuedTo);
};
function allBookList(data) {
    var self = this;
    self.bookTitle = ko.observable(data.bookTitle);
    self.author = ko.observable(data.author);
    self.quantity = ko.observable(data.quantity);
};
//library view model
var bookIssuedVM = function () { 
    
    var self = this;

    self.allIssuedItems = ko.observableArray();
    self.allBookItems = ko.observableArray();
    self.applyTemplate = function (container, viewModelInst) {
        var listContainer = jQ(container)[0];
        ko.cleanNode(listContainer);
        ko.applyBindings(viewModelInst, listContainer);
        return true;
    };
    self.AddBooksToUserIssued = function (data) {
        var ln = data.length;
        for (i = 0; i < ln; i++) {
            self.allIssuedItems.push(new booksIssuedToUser(data[i]));
        }

    };
    self.AddBooksToBookList = function (data) {
        var ln = data.length;
        for (i = 0; i < ln; i++) {
            self.allBookItems.push(new allBookList(data[i]));
        }

    };
    function init() {
        //get from list he json object of bookissueedlist
        var data = [{
            Title: "abc title1",
            IssuedTo: "rahul dravid"
        }, {
            Title: "abc title2",
            IssuedTo: "rahul dravid"
        }, {
            Title: "abc title3",
            IssuedTo: "rahul dravid"
        }, {
            Title: "abc title4",
            IssuedTo: "rahul dravid"
        }];
        var bookListData = [{
            bookTitle: "happy Potter",
            author: "j k Rowling",
            quantity: 5
        }, {
            bookTitle: "happy Potter",
            author: "j k Rowling",
            quantity: 5
        }, {
            bookTitle: "happy Potter",
            author: "j k Rowling",
            quantity: 5
        }, {
            bookTitle: "happy Potter",
            author: "j k Rowling",
            quantity: 5
        }];
        self.AddBooksToUserIssued(data);
        self.AddBooksToBookList(bookListData);
    };
    self.printIssuedBooks = function () {
        logger.log("Displaying user issued books. get data from list");

        var rootWeb = appContext.get_web();
        var spListobj = rootWeb.get_lists().getByTitle("Book Lists");
        var spCamlQuery = new SP.CamlQuery();

        var spViewXML = '<View><Query><OrderBy><FieldRef Name="Title" Ascending="True"></FieldRef></OrderBy></Query></View>';
        spCamlQuery.set_viewXml(spViewXML);

        spListobjItems = spListobj.getItems(spCamlQuery);
        appContext.load(spListobjItems, "Include(Title)"); //, DateofIssue, IssuedTo, DateofReturn, RatingsofBook
        appContext.executeQueryAsync(Function.createDelegate(this, onQuerySuccess), Function.createDelegate(this, onQueryFailed));

        function onQuerySuccess() {
            logger.log("Succeded");
            //console.log(this.spListobjItems.get_count());
            //debugger;
            var itemEnum = spListobjItems.getEnumerator();

            if (spListobjItems.get_count() > 0) {

                while (itemEnum.moveNext()) {
                    var currentItem = itemEnum.get_current();
                    var data = {
                        Title: currentItem.get_item("Title"),
                        //IssuedTo: currentItem.get_item("DateofIssue"),
                        //Title: currentItem.get_item("IssuedTo"),
                        //Title: currentItem.get_item("DateofReturn"),
                        //Title: currentItem.get_item("RatingsofBook")

                    };
                    self.AddBooksToUserIssued(data);
                    logger.log("Succeded in while");
                    return;
                }

            }

          
        };

        function onQueryFailed(sender, args) {
            console.log('Request failed. ' + args.get_message() + '\n' + args.get_stackTrace());
        };






    };

    init();

};





var app = (function (jQuery, trace, userService, context, bookService) {

    function _init() {
        trace.log("Bootstrap!!!");

        userService.PrintCurrentUser();
        var viewModelInst = new bookIssuedVM();
        viewModelInst.printIssuedBooks();
        var listContainer = jQ("#userbooklist")[0];
        viewModelInst.applyTemplate(listContainer, viewModelInst);

        var booklist = jQ("#allbooklist")[0];
        viewModelInst.applyTemplate(booklist, viewModelInst);



    };
    return {
        //load: _loadDependencies,
        init: _init
    };
})(jQ, logger, userModule, appContext, bookIssuedVM);




jQ(document).ready(function(){
    app.init();
});

/*






function onQueryFailed(sender, args) {
    console.log('Request failed. ' + args.get_message() + '\n' + args.get_stackTrace());
}

function onQuerySucceeded() {
    console.log('Item created: ' + oListItem.get_id());
}


function createListItem() {

    var oList = context.get_web().get_lists().getByTitle('Library Book Lists');
    var itemCreateInfo = new SP.ListItemCreationInformation();
    oListItem = oList.addItem(itemCreateInfo);
    oListItem.set_item('Title', '2 States');
    //oListItem.set_item('Author', 'Nitesh Patare');

    oListItem.update();

    context.load(oListItem);

    context.executeQueryAsync(Function.createDelegate(this, onQuerySucceeded), Function.createDelegate(this, onQueryFailed));
}

*/

