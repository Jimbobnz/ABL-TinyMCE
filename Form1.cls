 
/*------------------------------------------------------------------------
   File        : Form1
   Purpose     : 
   Syntax      : 
   Description : 
   Author(s)   : 
   Created     : 
   Notes       : 
 ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Windows.Form.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Form1 INHERITS Form: 
	
    DEFINE PRIVATE VARIABLE bntLoad      AS System.Windows.Forms.Button              NO-UNDO.
    DEFINE PRIVATE VARIABLE bntSave      AS System.Windows.Forms.Button              NO-UNDO.
    DEFINE PRIVATE VARIABLE components   AS System.ComponentModel.IContainer         NO-UNDO.
    DEFINE PRIVATE VARIABLE statusStrip1 AS System.Windows.Forms.StatusStrip         NO-UNDO.
    DEFINE PRIVATE VARIABLE webView21    AS Microsoft.Web.WebView2.WinForms.WebView2 NO-UNDO.
		
    CONSTRUCTOR PUBLIC Form1 (  ):

        InitializeComponent().
        THIS-OBJECT:ComponentsCollection:Add(THIS-OBJECT:components).
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.

    END CONSTRUCTOR.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID bntLoad_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		
        DEFINE VARIABLE javaScript AS CHARACTER NO-UNDO.
       
        javaScript = SUBSTITUTE("document.getElementById('mytextarea').innerText = '<h2>&1</h2>'; tinymce.get('mytextarea').load();", ISO-DATE(NOW) ).
        THIS-OBJECT:webView21:CoreWebView2:ExecuteScriptAsync(javaScript).
		
        RETURN.

    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID bntSave_Click( INPUT sender AS System.Object, INPUT e AS System.EventArgs ):
		
		
        DEFINE VARIABLE javaScript    AS CHARACTER NO-UNDO.
        DEFINE VARIABLE chReturnValue AS CLASS     "System.Threading.Tasks.Task<CHARACTER>" NO-UNDO.
        
        DEFINE VARIABLE i             AS INTEGER   NO-UNDO.
        DEFINE VARIABLE decodeReturnString AS CHARACTER NO-UNDO.
        
        javaScript = "document.getElementById('mytextarea').value".
        WAIT-FOR THIS-OBJECT:webView21:CoreWebView2:ExecuteScriptAsync(javaScript) SET chReturnValue.
        
        
         
        //I don't fully understand why I need to do this, but it works    
        do while NOT chReturnValue:IsCompleted :
            PROCESS EVENTS.
        end.    
        
        decodeReturnString = chReturnValue:Result. 
        
        decodeReturnString = CODEPAGE-CONVERT(decodeReturnString,  'ISO8859-1', 'UTF-8').
        
        decodeReturnString = replace(decodeReturnString, "\u003C", "<").
        decodeReturnString = replace(decodeReturnString, "\n", "~n").
        
        MESSAGE decodeReturnString
            VIEW-AS ALERT-BOX INFO TITLE "mytextarea Value".
                        
        chReturnValue:Dispose().
                         
        Delete object chReturnValue.        
		
        RETURN.

    END METHOD.

 
    METHOD PRIVATE VOID InitializeComponent(  ):
		
        /* NOTE: The following method is automatically generated.
        
        We strongly suggest that the contents of this method only be modified using the
        Visual Designer to avoid any incompatible modifications.
        
        Modifying the contents of this method using a code editor will invalidate any support for this file. */
        THIS-OBJECT:statusStrip1 = NEW System.Windows.Forms.StatusStrip().
        THIS-OBJECT:webView21 = NEW Microsoft.Web.WebView2.WinForms.WebView2().
        THIS-OBJECT:bntSave = NEW System.Windows.Forms.Button().
        THIS-OBJECT:bntLoad = NEW System.Windows.Forms.Button().
        CAST(THIS-OBJECT:webView21, System.ComponentModel.ISupportInitialize):BeginInit().
        THIS-OBJECT:SuspendLayout().
        /*  */
        /* statusStrip1 */
        /*  */
        THIS-OBJECT:statusStrip1:Dock = System.Windows.Forms.DockStyle:None.
        THIS-OBJECT:statusStrip1:Location = NEW System.Drawing.Point(601, 497).
        THIS-OBJECT:statusStrip1:Name = "statusStrip1".
        THIS-OBJECT:statusStrip1:Size = NEW System.Drawing.Size(202, 22).
        THIS-OBJECT:statusStrip1:TabIndex = 0.
        THIS-OBJECT:statusStrip1:Text = "statusStrip1".
        /*  */
        /* webView21 */
        /*  */
        THIS-OBJECT:webView21:AllowExternalDrop = TRUE.
        DEFINE VARIABLE nestedvar0 AS System.Windows.Forms.AnchorStyles NO-UNDO.
        nestedvar0 = CAST(Progress.Util.EnumHelper:Or(CAST(Progress.Util.EnumHelper:Or(System.Windows.Forms.AnchorStyles:Top, System.Windows.Forms.AnchorStyles:Bottom), System.Windows.Forms.AnchorStyles), System.Windows.Forms.AnchorStyles:Left), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:webView21:Anchor = CAST(Progress.Util.EnumHelper:Or(nestedvar0, System.Windows.Forms.AnchorStyles:Right), System.Windows.Forms.AnchorStyles).
        THIS-OBJECT:webView21:CreationProperties = ?.
        THIS-OBJECT:webView21:DefaultBackgroundColor = System.Drawing.Color:White.
        THIS-OBJECT:webView21:Location = NEW System.Drawing.Point(12, 12).
        THIS-OBJECT:webView21:Name = "webView21".
        THIS-OBJECT:webView21:Size = NEW System.Drawing.Size(741, 551).
        THIS-OBJECT:webView21:Source = NEW System.Uri("C:\Users\james\Progress\Developer Studio 12.8\workspace\ABL-TinyMCE\tinymce-example.html", System.UriKind:Absolute).
        THIS-OBJECT:webView21:TabIndex = 1.
        THIS-OBJECT:webView21:ZoomFactor = Progress.Util.CastUtil:ToDouble("1").
        THIS-OBJECT:webView21:NavigationCompleted:Subscribe(THIS-OBJECT:webView21_NavigationCompleted).
        /*  */
        /* bntSave */
        /*  */
        THIS-OBJECT:bntSave:Location = NEW System.Drawing.Point(93, 584).
        THIS-OBJECT:bntSave:Name = "bntSave".
        THIS-OBJECT:bntSave:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:bntSave:TabIndex = 2.
        THIS-OBJECT:bntSave:Text = "Save".
        THIS-OBJECT:bntSave:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:bntSave:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:bntSave:Click:Subscribe(THIS-OBJECT:bntSave_Click).
        /*  */
        /* bntLoad */
        /*  */
        THIS-OBJECT:bntLoad:Location = NEW System.Drawing.Point(12, 584).
        THIS-OBJECT:bntLoad:Name = "bntLoad".
        THIS-OBJECT:bntLoad:Size = NEW System.Drawing.Size(75, 23).
        THIS-OBJECT:bntLoad:TabIndex = 3.
        THIS-OBJECT:bntLoad:Text = "Load".
        THIS-OBJECT:bntLoad:UseCompatibleTextRendering = TRUE.
        THIS-OBJECT:bntLoad:UseVisualStyleBackColor = TRUE.
        THIS-OBJECT:bntLoad:Click:Subscribe(THIS-OBJECT:bntLoad_Click).
        /*  */
        /* Form1 */
        /*  */
        THIS-OBJECT:ClientSize = NEW System.Drawing.Size(765, 646).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:bntLoad).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:bntSave).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:webView21).
        THIS-OBJECT:Controls:Add(THIS-OBJECT:statusStrip1).
        THIS-OBJECT:Name = "Form1".
        THIS-OBJECT:Text = "Form1".
        CAST(THIS-OBJECT:webView21, System.ComponentModel.ISupportInitialize):EndInit().
        THIS-OBJECT:ResumeLayout(FALSE).
        THIS-OBJECT:PerformLayout().
        CATCH e AS Progress.Lang.Error:
            UNDO, THROW e.
        END CATCH.
    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/
    @VisualDesigner.
    METHOD PRIVATE VOID webView21_NavigationCompleted( INPUT sender AS System.Object, INPUT e AS Microsoft.Web.WebView2.Core.CoreWebView2NavigationCompletedEventArgs ):
		
		
		
		
        RETURN.

    END METHOD.

    DESTRUCTOR PUBLIC Form1 ( ):

    END DESTRUCTOR.

END CLASS.