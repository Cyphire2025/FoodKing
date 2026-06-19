const AppIntroVideoComponent = () => import("../../components/admin/appIntroVideo/AppIntroVideoComponent");

export default [
    {
        path: "/admin/app-intro-video",
        component: AppIntroVideoComponent,
        name: "admin.app-intro-video",
        meta: {
            isFrontend: false,
            auth: true,
            permissionUrl: "items",
            breadcrumb: "app_intro_video",
        },
    },
];
