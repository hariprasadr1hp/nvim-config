use nvim_oxi::{self as oxi};

mod commands;
mod windows;

#[oxi::plugin]
fn oxitools() -> oxi::Result<()> {
    commands::register()?;
    windows::register()?;

    Ok(())
}
