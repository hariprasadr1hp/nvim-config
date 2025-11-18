use chrono::Local;
use nvim_oxi as oxi;
use oxi::api;
use oxi::api::opts::{CreateCommandOpts, EchoOpts, SetKeymapOpts};
use oxi::api::types::CommandArgs;
use oxi::api::types::Mode;
use oxi::Result;

pub fn register() -> Result<()> {
    let cmd_opts = CreateCommandOpts::builder().build();

    api::create_user_command(
        "PrintDate",
        |_: CommandArgs| -> Result<()> {
            let now = Local::now();
            let formatted = now.format("%Y-%m-%d %H:%M:%S").to_string();

            api::echo([(formatted, None::<&str>)], false, &EchoOpts::default())?;
            Ok(())
        },
        &cmd_opts,
    )?;

    api::create_user_command(
        "PrintTime",
        |_: CommandArgs| -> Result<()> {
            let now = Local::now();
            let formatted = now.format("%H:%M:%S").to_string();

            api::echo([(formatted, None::<&str>)], false, &EchoOpts::default())?;
            Ok(())
        },
        &cmd_opts,
    )?;

    let km_opts = SetKeymapOpts::builder().noremap(true).silent(true).build();

    api::set_keymap(Mode::Normal, "<leader>pd", ":PrintDate<CR>", &km_opts)?;

    Ok(())
}
