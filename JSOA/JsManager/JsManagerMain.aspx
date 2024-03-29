﻿<%@ Page Title="" Language="C#" MasterPageFile="~/JsManager/Manager_Master.master" AutoEventWireup="true" CodeFile="JsManagerMain.aspx.cs" Inherits="JsManager_JsManagerMain" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Manager_ContentPlaceHolder" Runat="Server">
   <div style="height: 503px" >
    <div class="JCM_left">
        
        <div class="JCM_pro"><a href="../Change/Change.aspx" title="点击更换头像">
            <img src="<%=imageUrl %>" id="ImgProfile" style="width: 220px; height: 226px;" /></a></div>
        <div class="JCM_info">姓名：<asp:Label ID="lblName" runat="server" Text="Name"></asp:Label></div>
        <div class="JCM_info">院系：<asp:Label ID="lblAcademy" runat="server" Text="Academy"></asp:Label></div>
        <div class="JCM_info">组别：<asp:Label ID="lblPosition" runat="server" Text="Position"></asp:Label></div>
    </div>
    <div class="JCM_right">
        <div style="width:100%;height:16px;margin-top:5px;position:relative;border-top-left-radius:10px; border-top-right-radius:10px;">
            <div style="position:absolute; text-align:center;margin-left:200px;margin-top:2px;background-color:yellowgreen;color:black">
                <h4>我喜欢的一句话*_*</h4>
            </div>
        </div>
        <asp:ScriptManager ID="JsManagerMain_ScriptManager" runat="server" EnablePartialRendering="true">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="AphorismUpdatePanel" runat="server" UpdateMode="Always" ChildrenAsTriggers="true">
            <ContentTemplate>
              <div class="notice">
                <table>
                    <tr>
                        <td>
                            <asp:Repeater ID="AphorismRepeater" runat="server" OnItemCommand="JobAphorismRepeater_ItemCommand">
                                <ItemTemplate>
                                    <tr style="width:100%;height:20px">
                                        <h3>
                                            <asp:Label ID="AphorismLabel" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"jobAphorism")%>'></asp:Label>
                                        </h3>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </td>
                    </tr>
                </table>
              </div>
              <div style="float:right">
                  <asp:ImageButton ID="AphorismWrite" runat="server" ImageUrl="~/Image/JsCommonMain/Notice.png" OnClick="ImgbtnAphorism_Click" />
              </div>
          </ContentTemplate>
       </asp:UpdatePanel>
        
     </div>
  </div>
</asp:Content>

