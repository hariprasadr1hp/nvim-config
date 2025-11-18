use nvim_oxi::{self as nvim_oxi};

mod commands;
mod windows;

#[nvim_oxi::plugin]
fn oxitools() -> nvim_oxi::Result<()> {
    commands::register()?;
    windows::register()?;

    Ok(())
}
