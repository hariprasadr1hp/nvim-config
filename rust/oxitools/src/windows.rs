use nvim_oxi as oxi;
use oxi::Result;
use oxi::api::opts::CreateCommandOpts;
use oxi::api::types::CommandArgs;
use oxi::api::{self, Window};

pub fn register() -> Result<()> {
    let cmd_opts = CreateCommandOpts::builder().build();

    // :WinInfo – print info about current window
    api::create_user_command(
        "WinInfo",
        |_args: CommandArgs| -> Result<()> {
            let win = Window::current();
            let width = win.get_width()?;
            let height = win.get_height()?;
            let msg = format!("Current window: {width}x{height}");
            api::echo([(msg, None::<&str>)], false, &Default::default())?;
            Ok(())
        },
        &cmd_opts,
    )?;

    // :WinList – list all windows
    api::create_user_command(
        "WinList",
        |_args: CommandArgs| -> Result<()> {
            let wins: Vec<Window> = api::list_wins().collect();
            let msg = format!("There are {} windows", wins.len());
            api::echo([(msg, None::<&str>)], false, &Default::default())?;
            Ok(())
        },
        &cmd_opts,
    )?;

    Ok(())
}
