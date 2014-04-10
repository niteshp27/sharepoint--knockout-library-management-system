<%-- The following 4 lines are ASP.NET directives needed when using SharePoint components --%>

<%@ Page Inherits="Microsoft.SharePoint.WebPartPages.WebPartPage, Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" MasterPageFile="../_catalogs/masterpage/MasterPageGallery/people.master" Language="C#" %>

<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<%-- The markup and script in the following Content element will be placed in the <head> of the page --%>
<asp:Content ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
    <%--<script type="text/javascript" src="../Scripts/jquery-1.9.1.min.js"></script>--%>

    <script type="text/javascript" src="../_layouts/15/sp.runtime.js"></script>
    <script type="text/javascript" src="../_layouts/15/sp.js"></script>
    <meta name="WebPartPageExpansion" content="full" />
</asp:Content>

<%-- The markup in the following Content element will be placed in the TitleArea of the page --%>
<asp:Content ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server">
    Application Dashboard
</asp:Content>

<%-- The markup and script in the following Content element will be placed in the <body> of the page --%>
<asp:Content ContentPlaceHolderID="PlaceHolderMain" runat="server">
        <SharePoint:ScriptLink language="javascript" name="SP.js" defer="true" runat="server" Localizable="false"/>
    <div class="row">
                                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                        <h2>
                                            <span class="glyphicon glyphicon-repeat">
                                            </span>
<!-- Title -->
											<span>Dashboard</span> - <span id="message"></span>
                                        </h2>
                                        <ul class="pager">
                                            <li class="">
                                                <a href="#" onclick="issueBook();" >
                                                    <span class="glyphicon glyphicon-user">
                                                    </span>
                                                    Issue Book
                                                </a>
                                            </li>
                                           <%-- <li class="">
                                                <a href="/Addgoals.aspx">
                                                    <span class="glyphicon glyphicon-flag">
                                                    </span>
                                                    Return Book
                                                </a>
                                            </li>--%>
                                           <%-- <li class="">
                                                <a href="/Selfrating.aspx">
                                                    <span class="glyphicon glyphicon-pencil">
                                                    </span>
 Self Rating                                                </a>
                                            </li>
                                            <li class="">
                                                <a href="/Feedback.aspx">
                                                    <span class="glyphicon glyphicon-list">
                                                    </span>
 Feedback                                                </a>
                                            </li>
                                            <li class="">
                                                <a href="/Summary.aspx">
                                                    <span class="glyphicon glyphicon-repeat">
                                                    </span>
 Summary                                                </a>
                                            </li>--%>
                                        </ul>
                                            <div>
                                                <span id="message"></span>
                                            </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4>
                                                    <span class="glyphicon glyphicon-flag">
                                                    </span>
                                         </h4>
                                            </div>
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class=" boxPanel">
                                                       <div id="userbooklist" data-bind="template: { name: 'BooksIssuedTemplate', foreach: items }">
                                                           
                                                       </div>
                                                        
                                                    </div>
                                                </div>
                                               
                                            </div>
                                        </div>
                                    </div>
                                </div>



                                    <div class="row">
                                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4>
                                                    <span class="glyphicon glyphicon-flag">
                                                    </span>
                                          </h4>
                                            </div>
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class=" boxPanel">
                                                       <%--<div id="booklist" data-bind="template: { name: 'BooksListTemplate', foreach: items }">
                                                           
                                                       </div>--%>
                                                        
                                                    </div>
                                                </div>
                                               
                                            </div>
                                        </div>
                                    </div>
                                </div>

<%--<script Id="BooksListTemplate" type="text/html">
     <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
        <div class="bookTitle">qqq</div>
        <div class="TotalBooks">100</div>
    </div>    
</script>--%>

<script Id="BooksIssuedTemplate" type="text/html">
    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
        <div data-bind="text: Title">
             XXX
        </div>
        <div class="progress">
            <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%">
                <span class="sr-only">
                     100% Complete
                </span>
            </div>
        </div>
        <p data-bind="text: IssuedTo">
            Create an app in Sharepoint
        </p>
        <p>
            Long term goal
        </p>
        <p>
            <span class="label label-success">
                Successfull
            </span>
        </p>
    </div>   
</script>

</asp:Content>
