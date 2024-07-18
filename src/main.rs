slint::include_modules!();
mod db;

fn main() {
    AppWindow::new().unwrap().run().unwrap();
}
