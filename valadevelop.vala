
static int main(string[] args)
{
	return new MainApplication ().run (args);
}

public class MainApplication : Gtk.Application
{
	/* Override the 'activate' signal of GLib.Application. */
	protected override void activate () {
		/* Create the window of this application and show it. */
		var window = new MainApplicationWindow (this);
		window.show ();
	}
}

[GtkTemplate (ui = "/org/gtk/valadevelop/applicationwindow.glade")]
internal class MainApplicationWindow : Gtk.ApplicationWindow
{
	[GtkChild]Gtk.Paned mainPaned;
	[GtkChild]Gtk.Paned childPaned;
	[GtkChild]Gtk.Paned infoPaned;
	[GtkChild]Gtk.TreeView solutionTreeView;
	[GtkChild]Gtk.TreeStore solutionStore;
	
	public MainApplicationWindow(Gtk.Application application)
	{
		new Gtk.ApplicationWindow(application);

		int width;
		int height;
		get_size(out width, out height);
		mainPaned.set_position(width / 100 * 30);
		childPaned.set_position(width - mainPaned.get_position() - width / 100 * 30);
		infoPaned.set_position(height - height / 100 * 30);

		var column = new Gtk.TreeViewColumn();
		column.set_sizing(Gtk.TreeViewColumnSizing.FIXED);
		var pixbuf = new Gtk.CellRendererPixbuf();
		var cell = new Gtk.CellRendererText();

		column.pack_start(pixbuf, false);
		column.pack_start(cell, true);

		column.add_attribute(cell,"text",0);
		column.add_attribute(pixbuf,"pixbuf",1);

		solutionTreeView.append_column (column);

		Gtk.TreeIter root;
		Gtk.TreeIter child;
		
		solutionStore.append (out root, null);
		
		solutionStore.set_value (root, 0, "solution");
		solutionStore.set_value (root, 1, Gtk.IconTheme.get_default().load_icon("package-x-generic", 16, 0));
		solutionStore.append (out child, root);
		solutionStore.set_value (child, 0, "project");
		solutionStore.set_value (child, 1, Gtk.IconTheme.get_default().load_icon("text-x-script", 16, 0));
					
		//solutionTreeView.model = solutionStore;
		solutionTreeView.expand_all();
	}
}

