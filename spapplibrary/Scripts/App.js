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
                jQ('#message').text('Hello ' + user.get_title());
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

//library view model
var bookIssuedVM = function () { //jQ, ko, trace, context
    //var bookService = function () {

    var self = this;

    self.items = ko.observableArray();
    self.applyTemplate = function (container, viewModelInst) {
        var listContainer = jQ(container)[0];
        ko.cleanNode(listContainer);
        ko.applyBindings(viewModelInst, listContainer);
        return true;
    };
    self.AddBooksToUserIssued = function (data) {
        self.items.push(new booksIssuedToUser(data)); //, data.IssuedTo
    };
    function init() {
        //get from list he json object of bookissueedlist
        var data = {
            Title: "abc title",
            IssuedTo: "rahul dravid"
        };
        self.AddBooksToUserIssued(data);
    };
    function printIssuedBooks() {
        logger.log("Displaying user issued books. get data from list");

        var rootWeb = appContext.get_web();
        var spListobj = rootWeb.get_lists().getByTitle("Book Lists");
        var spCamlQuery = new SP.CamlQuery();

        var spViewXML = '<View><Query><OrderBy><FieldRef Name="Title" Ascending="True"></FieldRef></OrderBy></Query></View>';
        spCamlQuery.set_viewXml(spViewXML);

        spListobjItems = spListobj.getItems(spCamlQuery);
        appContext.load(spListobjItems, "Include(Title, IssuedTo)"); //, Issued To, Date of issue, Date of Return, Ratings of Book
        appContext.executeQueryAsync(Function.createDelegate(this, onQuerySuccess), Function.createDelegate(this, onQueryFailed));

        function onQuerySuccess() {
            logger.log("Succeded");
            debugger;
            var itemEnum = spListobjItems.getEnumerator();

            if (spListobjItems.get_count() > 0) {

                while (itemEnum.moveNext()) {
                    var currentItem = itemEnum.get_current();
                    var data = {
                        Title: currentItem.get_item("Title"),
                        IssuedTo:  currentItem.get_item("IssuedTo")
                    };
                    self.AddBooksToUserIssued(data);
                    logger.log("Succeded in while");
                }

            }

           // var viewModelInst = new bookIssuedVM();
//            var listContainer = jQ("#userbooklist")[0];
  //          viewModelInst.applyTemplate(listContainer, viewModelInst);
        };

        function onQueryFailed(sender, args) {
            console.log('Request failed. ' + args.get_message() + '\n' + args.get_stackTrace());
        };






    };

    init();
    printIssuedBooks();

    //return {
    //    applyTemplate: self.applyTemplate,
    //    issueBook: self.issueBook
    //};
    //};


    ////return new bookService();
};
//(jQ, window.ko, logger, appContext);




var app = (function (jQuery, trace, userService, context, bookService) {

    function _init() {
        trace.log("Bootstrap!!!");

        userService.PrintCurrentUser();
        //bookService.applyTemplate("#userbooklist", new bookService());

        //ko.applyBindings(new IssusBookInstance, "#id");
               

    };
    return {
        //load: _loadDependencies,
        init: _init
    };
})(jQ, logger, userModule, appContext, bookIssuedVM);




jQ(document).ready(function(){
    app.init()
    var viewModelInst = new bookIssuedVM();
    var listContainer = jQ("#userbooklist")[0];
    viewModelInst.applyTemplate(listContainer, viewModelInst);

    //ko.cleanNode(listContainer);
    //ko.applyBindings(viewModelInst, listContainer);
});

/*
var libraryVM = (function (jQ, ko, trace, context) {
    debugger;
    ko = window.ko || ko;
    var libraryList = function () {
        var self = this;



        self.issueBook = function()  {
            var currUrl = context.get_url();
            var _cururl = 'https://' + window.location.host + currUrl;
            _cururl += '/Lists/LibraryBookLists/NewForm.aspx?RootFolder=';
            SP.UI.ModalDialog.showModalDialog({ url: _cururl, title: 'Issue Book', allowMaximize: true, showClose: true });
            trace.log("url");
            return false;
        };
        self.bookList = function () {
            self.applyTemplate("#booklist", self);
        };
        self.BooksIssuedToUser = ko.observableArray([]);
        
        self.AddBooksIssuedToUser = function (data) {
            self.BooksIssuedToUser.push(new booksIssuedToUserList(data));
        }

        self.userBookList = function () {
            console.log("displaying user issued books. get data from list");
            var rootWeb = context.get_web();
            var spListobj = rootWeb.get_lists().getByTitle("Book Lists");
            var spCamlQuery = new SP.CamlQuery();

            var spViewXML = '<View><Query><OrderBy><FieldRef Name="Author" Ascending="True"></FieldRef></OrderBy></Query></View>';
            spCamlQuery.set_viewXml(spViewXML);

            spListobjItems = spListobj.getItems(spCamlQuery);
            context.load(spListobjItems, "Include(Title, Author, Ratings of Book)");
            context.executeQueryAsync(Function.createDelegate(this, onQuerySuccess), Function.createDelegate(this, onQueryFailed));

            function onQuerySuccess() {
                trace.log("Succeded");
                var itemEnum = spListobjItems.getEnumerator();

                if (spListobjItems.get_count() > 0) {

                    while (itemEnum.moveNext()) {

                        var currentItem = itemEnum.get_current();

                        var dataToReturn = currentItem.get_item("json");

                    }
                }
                

                self.applyTemplate("#userbooklist", libraryVM);
            };

            function onQueryFailed() {
                trace.log("Failed");
            };
            
        };
        self.applyTemplate = function (container, viewModel) {
            var listContainer = jQ(container)[0];
            ko.cleanNode(listContainer);
            ko.applyBindings(viewModel, listContainer);
            return true;
        };
        return {
            userBookList: self.userBookList,
            issueBook: self.issueBook
        };

    };

    return new libraryList();

})(jQ,window.ko || '',logger,appContext);

//to do seperate view model
var libraryEntityVM = (function (jQ, ko, trace, context) {

})(jQ, "../Scripts/knockout-3.1.0.debug.js", logger, appContext);


*/




//function onQueryFailed(sender, args) {
//    console.log('Request failed. ' + args.get_message() + '\n' + args.get_stackTrace());
//}

//function onQuerySucceeded() {
//    console.log('Item created: ' + oListItem.get_id());
//}


//function createListItem() {

//    var oList = context.get_web().get_lists().getByTitle('Library Book Lists');
//    var itemCreateInfo = new SP.ListItemCreationInformation();
//    oListItem = oList.addItem(itemCreateInfo);
//    oListItem.set_item('Title', '2 States');
//    //oListItem.set_item('Author', 'Nitesh Patare');

//    oListItem.update();

//    context.load(oListItem);

//    context.executeQueryAsync(Function.createDelegate(this, onQuerySucceeded), Function.createDelegate(this, onQueryFailed));
//}



//var serverRelativeWebURL = '';

//function onQuerySuccess(sender, args) {
//    console.log(this.spListobjItems.get_count());
//}

//function getlist() {
//    var clientContext = new SP.ClientContext.get_current();
//    var rootWeb = clientContext.get_web();
//    var spListobj = rootWeb.get_lists().getByTitle("Book Lists");
//    var spCamlQuery = new SP.CamlQuery();

//    var spViewXML = '<View><Query><OrderBy><FieldRef Name="Author" Ascending="True"></FieldRef></OrderBy></Query></View>';
//    spCamlQuery.set_viewXml(spViewXML);
//    spListobjItems = spListobj.getItems(spCamlQuery);
//    clientContext.load(spListobjItems);
//    clientContext.executeQueryAsync(Function.createDelegate(this, onQuerySuccess), Function.createDelegate(this, onQueryFailed));
//}
